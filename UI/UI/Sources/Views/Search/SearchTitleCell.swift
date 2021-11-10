//
//  SearchTitleCell.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class SearchTitleCell: BaseCollectionViewCell {
    // MARK: - Constants

    private struct Image {
        static let chevronDownImage = UIImage(systemName: "chevron.down")
        static let chevronUpImage = UIImage(systemName: "chevron.up")
    }

    // MARK: - Variables

    private var timer: Timer = Timer()
    private var isTimerOn: Bool = false
    private var index: Int = 0

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        return label
    }()

    private let termLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        return label
    }()

    private let chevronButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(Image.chevronDownImage, for: .normal)
        button.setImage(Image.chevronUpImage, for: .selected)
        button.tintColor = .label
        button.isUserInteractionEnabled = false
        return button
    }()

    private let dividerView = DividerView()

    // MARK: - Initialization

    override func setupViews() {
        contentView.addSubviews(
            titleLabel,
            termLabel,
            dividerView,
            chevronButton
        )

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        chevronButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            termLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            termLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            dividerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            chevronButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }

    // MARK: - Methods

    func bind(data: Search) {
        chevronButton.isSelected = data.isExpand
        titleLabel.text = data.title
        titleLabel.isHidden = data.isExpand

        if data.isExpand == true {
            timer.invalidate()
            index = 0
            isTimerOn = false
            termLabel.text = data.title
        } else {
            termLabel.text = "\(index + 1). \(data.terms[index])"
            if isTimerOn == false {
                isTimerOn = true
                timer = Timer.scheduledTimer(
                    withTimeInterval: 2,
                    repeats: true,
                    block: { _ in
                        self.termLabel.text = "\(self.index + 1). \(data.terms[self.index])"
                        self.index += 1
                        if self.index == data.terms.count {
                            self.index = 0
                        }
                    }
                )
            }
        }
    }
}
