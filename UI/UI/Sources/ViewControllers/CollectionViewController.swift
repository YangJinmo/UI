//
//  CollectionViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class CollectionViewController: BaseViewController {
    // MARK: - Constants

    private let vcName: String = "추천 검색어"

    // MARK: - Variables

    private var searches: [Search] = [
        Search(
            isExpand: false,
            title: "인기 검색",
            terms: ["캠핑", "가방", "고양이", "건전지", "오미자"]
        ),
        Search(
            isExpand: false,
            title: "최근 검색",
            terms: ["충전기", "강아지", "개구리", "두꺼비", "아이유"]
        ),
        Search(
            isExpand: false,
            title: "연관 검색",
            terms: ["보충제", "고구마", "헬스장", "런닝머신", "다이어트"]
        ),
    ]

    // MARK: - Views

    private lazy var collectionView: BaseCollectionView = {
        let collectionView: BaseCollectionView = BaseCollectionView(layout: flowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchTitleCell.self)
        collectionView.register(SearchTermCell.self)
        return collectionView
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setTitleLabel(vcName)
    }

    // MARK: - UIViewController Transition Coordinator

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

    // MARK: - Methods

    private func setupViews() {
//        contentView.addSubviews(collectionView)

//        contentView.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
//        contentView.addConstraintsWithFormat("V:|[v0]|", views: collectionView)

//        collectionView.edges()
//        collectionView.edges(equalTo: contentView)

        contentView.add(
            collectionView,
            edges: contentView
        )
    }
}

// MARK: - UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searches[section].isExpand == true {
            return searches[section].terms.count + 1
        } else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell: SearchTitleCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.bind(data: searches[indexPath.section])
            return cell
        default:
            let cell: SearchTermCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.bind(
                rank: indexPath.item,
                term: searches[indexPath.section].terms[indexPath.item - 1]
            )
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            searches[indexPath.section].isExpand.toggle()

            let sections: IndexSet = IndexSet(integer: indexPath.section)
            collectionView.reloadSections(sections)
        } else {
            print(searches[indexPath.section].terms[indexPath.item - 1])
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return itemSize(width: collectionView, height: SearchTitleCell.itemHeight)
        default:
            return itemSize(width: collectionView, height: SearchTermCell.itemHeight)
        }
    }
}

// MARK: - FlowLayoutMetric

extension CollectionViewController: FlowLayoutMetric {
    var numberOfItemForRow: CGFloat {
        1
    }

    var sectionInset: UIEdgeInsets {
        .uniform(size: 0)
    }

    var minimumLineSpacing: CGFloat {
        1
    }

    var minimumInteritemSpacing: CGFloat {
        0
    }
}
