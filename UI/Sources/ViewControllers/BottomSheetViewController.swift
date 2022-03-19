//
//  BottomSheetViewController.swift
//  UI
//
//  Created by Jmy on 2022/02/13.
//

import UIKit

final class BottomSheetViewController: UIViewController {
    // MARK: - Properties

    private var margin = CGFloat(16)
    private var contentViewTopConstraint: NSLayoutConstraint!
    private var contentViewTop: CGFloat {
        return safeAreaHeight + safeAreaBottom
    }

    private var contentViewHeightConstraint: NSLayoutConstraint!
    private var contentViewHeight: CGFloat {
        return Height.navigationController + collectionViewHeight + safeAreaBottom + margin
    }

    private var collectionViewHeight: CGFloat {
        collectionView.layoutIfNeeded()
        return collectionView.contentSize.height
    }

    // MARK: - Views

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0
        return view
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let rectCorner: UIRectCorner = [.topLeft, .topRight]
        view.layer.masksToBounds = false
        view.layer.maskedCorners = CACornerMask(rawValue: rectCorner.rawValue)
        view.layer.cornerRadius = 14
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()

    private lazy var navigationView = NavigationView()
    private lazy var collectionView: BaseCollectionView = {
        let collectionView = BaseCollectionView(layout: flowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SelectableLabelCell.self)
        return collectionView
    }()

    // MARK: - View Life Cycle

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        showBottomSheet()
    }

    // MARK: - Methods

    private func setupViews() {
        view.addSubviews(backgroundView)

        Constraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        view.addSubviews(contentView)

        contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: contentViewTop)
        contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: contentViewHeight)

        Constraint.activate([
            contentViewTopConstraint,
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentViewHeightConstraint,
        ])

        contentView.addSubviews(
            collectionView,
            navigationView
        )

        Constraint.activate([
            navigationView.topAnchor.constraint(equalTo: contentView.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Height.navigationController),
        ])

        Constraint.activate([
            collectionView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(safeAreaBottom + margin)),
        ])

        backgroundView.addTapGestureRecognizer(self, action: #selector(backgroundViewTouched(_:)))
        navigationView.addDismissButton(dismissButtonTouched)
    }

    private func showBottomSheet() {
        contentViewTopConstraint.constant = contentViewTop - contentViewHeight
        contentViewHeightConstraint.constant = contentViewHeight

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundView.alpha = 1
            self.view.layoutIfNeeded()
        })
    }

    private func hideBottomSheetAndDismiss(completion: (() -> Void)? = nil) {
        contentViewTopConstraint.constant = contentViewTop

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundView.alpha = 0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: completion)
            }
        }
    }

    @objc private func backgroundViewTouched(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndDismiss()
    }

    @objc private func dismissButtonTouched() {
        hideBottomSheetAndDismiss()
    }

    func setTitleLabel(_ text: String?) {
        navigationView.setTitleLabel(text)
    }

    private var sorts = [Sort]()
    private var selectedSort = Sort.dateOrder

    func bind(sorts: [Sort], selectedSort: Sort) {
        self.sorts = sorts
        self.selectedSort = selectedSort

        collectionView.reloadData { [weak self] in
            self?.selectedItem(selectedSort: selectedSort)
        }
    }

    private var didSelectItemAt: ((Sort) -> Void)?

    func bind(didSelectItemAt: @escaping (Sort) -> Void) {
        self.didSelectItemAt = didSelectItemAt
    }

    func selectedItem(selectedSort: Sort) {
        var indexPath: IndexPath?

        for (index, sort) in sorts.enumerated() {
            if sort == selectedSort {
                indexPath = IndexPath(item: index, section: 0)
            }
        }
        selectItem(indexPath: indexPath)
    }

    private func selectItem(indexPath: IndexPath? = IndexPath(item: 0, section: 0)) {
        collectionView.selectItem(
            at: indexPath,
            animated: true,
            scrollPosition: .centeredVertically
        )
    }
}

// MARK: - UICollectionViewDataSource

extension BottomSheetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sorts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SelectableLabelCell = collectionView.dequeueReusableCell(for: indexPath)
        let sort = sorts[indexPath.row]
        cell.setTitleLabel(sort.description)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension BottomSheetViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSort = sorts[indexPath.row]

        hideBottomSheetAndDismiss { [weak self] in
            self?.didSelectItemAt?(selectedSort)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BottomSheetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize(width: collectionView, height: SelectableLabelCell.itemHeight)
    }
}

// MARK: - FlowLayoutMetric

extension BottomSheetViewController: FlowLayoutMetric {
    var numberOfItemForRow: CGFloat {
        1.0
    }

    var sectionInset: UIEdgeInsets {
        .uniform(size: 0.0)
    }

    var minimumLineSpacing: CGFloat {
        1.0
    }

    var minimumInteritemSpacing: CGFloat {
        0.0
    }
}
