//
//  ScrollableStackViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/29.
//

import UIKit

final class ScrollableStackViewController: UIViewController {
    // MARK: - Constants

    private let vcName = "ScrollableStackViewController"

    // MARK: - Views

    private lazy var tabView = TabView(title: vcName)
    private lazy var titleLabel = UILabel.text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    )
    private lazy var subtitleLabel = UILabel.text(
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
    )
    private lazy var presentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .label
        button.layer.cornerRadius = 8
        return button
    }()

    // MARK: - View Life Cycle

    override func loadView() {
        presentButton.height(44)
        presentButton.addTarget(self, action: #selector(presentButtonTouched(_:)), for: .touchUpInside)

        tabView.dismissButton.isHidden = false
        tabView.dismissButton.setImage(nil, for: .normal)
        tabView.dismissButton.setTitle("Hide", for: .normal)
        tabView.dismissButton.setTitleColor(.label, for: .normal)
        tabView.dismissButton.addTarget(self, action: #selector(dismissButtonTouched), for: .touchUpInside)

        tabView.setupScrollableStackView(
            titleLabel,
            subtitleLabel,
            presentButton,
            margin: 20
        )

        view = tabView
    }

    @objc private func dismissButtonTouched(_ sender: UIButton) {
        sender.isSelected.toggle()

        if sender.isSelected {
            tabView.stackView.make(viewsHidden: [subtitleLabel], viewsVisible: [titleLabel], animated: true)
        } else {
            tabView.stackView.make(viewsHidden: [], viewsVisible: [titleLabel, subtitleLabel], animated: true)
        }
    }

    @objc private func presentButtonTouched(_ sender: Any) {
//        let urlString: String?
//        let urlString: String? = ""
//        let urlString: String? = "https"
//        let urlString: String? = "https:" // catch error: The file couldn’t be opened.
        let urlString: String? = "https://blog.kakaocdn.net/dn/0ZgUD/btqDljigiKg/JhrTd8H9kF2KOztZ7HhFu1/img.jpg"

        guard
            let urlString = urlString,
            let url = urlString.toURL,
            url.canOpenURL
        else {
            toast("실행 오류\n\n이미지 주소가 유효하지 않기 때문에\n해당 이미지를 불러올 수 없습니다.")
            return
        }
        present(ImagePresentViewController(imageUrl: url))
    }
}
