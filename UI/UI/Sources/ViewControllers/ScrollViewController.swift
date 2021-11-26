//
//  ScrollViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/25.
//

import UIKit

final class ScrollViewController: UIViewController {
    // MARK: - Views

    let scrollView = BaseScrollView()
    let contentView = UIView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    // MARK: - Layout Constraint

    private var topConstraint: Constraint? {
        didSet {
            if oldValue != nil {
                view.removeConstraint(oldValue!)
            }
            if topConstraint != nil {
                view.addConstraint(topConstraint!)
            }
        }
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        view.safeAreaInsets.top.description.log()
        view.safeAreaInsets.bottom.description.log()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        view.safeAreaInsets.top.description.log()
        view.safeAreaInsets.bottom.description.log()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.safeAreaInsets.top.description.log()
        view.safeAreaInsets.bottom.description.log()
    }

    // MARK: - Methods

    private func setupViews() {
//        view.addSubviews(scrollView)
//        scrollView.addSubviews(contentView)

//        Constraint.activate([
//            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//        ])

//        contentView.addSubviews(
//            titleLabel,
//            subtitleLabel
//        )

//        Constraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
//            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 4 / 5),
//
//            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
//            subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 4 / 5),
//            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
//        ])

        view.add(
            subview: scrollView,
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.bottomAnchor,
            width: view.widthAnchor,
            centerX: view
        )

        scrollView.add(
            subview: contentView,
            top: scrollView.topAnchor,
            bottom: scrollView.bottomAnchor,
            width: scrollView.widthAnchor,
            centerX: scrollView
        )

        contentView.add(
            subview: titleLabel,
            top: contentView.topAnchor, 24,
            width: contentView.widthAnchor, multiplier: 4 / 5,
            centerX: contentView
        )

        contentView.add(
            subview: subtitleLabel,
            top: titleLabel.bottomAnchor, 24,
            bottom: contentView.bottomAnchor, 24,
            width: contentView.widthAnchor, multiplier: 4 / 5,
            centerX: contentView
        )

        // test
        // topConstraint = view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        // topConstraint?.isActive = true
        // ==
        // topConstraint = view.top(titleLabel.bottomAnchor, 0)
        // topConstraint?.isActive = false
    }
}
