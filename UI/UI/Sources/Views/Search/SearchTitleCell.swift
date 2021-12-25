//
//  SearchTitleCell.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class SearchTitleCell: BaseCollectionViewCell {
    // MARK: - Variables

    static var itemHeight: CGFloat {
        return 76
    }

    private var timer: Timer = Timer()
    private var isTimerOn: Bool = false
    private var index: Int = 0

    // MARK: - Constants

    private enum Image {
        static let chevronDownImage = UIImage(systemName: "chevron.down")
        static let chevronUpImage = UIImage(systemName: "chevron.up")
    }

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private let termLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
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

    // MARK: - Methods

    override func setupViews() {
//        contentView.addSubviews(
//            titleLabel,
//            termLabel,
//            dividerView,
//            chevronButton
//        )

//        Constraint.activate([
//            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 36),
//            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//
//            termLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            termLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//
//            dividerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//            dividerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//
//            chevronButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            chevronButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -36),
//        ])

        contentView.add(
            titleLabel,
            left: contentView.leftAnchor, 36,
            centerY: contentView
        )

        contentView.add(
            termLabel,
            center: contentView
        )

        contentView.add(
            dividerView,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor
        )

        contentView.add(
            chevronButton,
            right: contentView.rightAnchor, 36,
            centerY: contentView
        )
        
//        contentView.constraints.first { $0.firstAnchor == titleLabel.leftAnchor }?.isActive = false
//
//        removeAnchor(left: titleLabel, right: chevronButton)
//
//        contentView.remove(anchorX: titleLabel.leftAnchor)
//        contentView.remove(anchorX: leftAnchor) // X
//
//        titleLabel.remove(left: contentView.leftAnchor)
//        titleLabel.remove(left: leftAnchor)
//        titleLabel.remove(left: titleLabel.leftAnchor)
//
//        titleLabel.left(equalTo: contentView.leftAnchor, constant: 50)
//
//        contentView.leftAnchor.remove(superview: titleLabel) // X
//        titleLabel.leftAnchor.remove(superview: contentView)
//
//        titleLabel.remove(left: contentView.leftAnchor)
//        titleLabel.remove(left: leftAnchor)
//
//        titleLabel.remake(left: contentView.leftAnchor, 60)
//
//        titleLabel.centerX(constant: 30)
//
//        titleLabel.remake(anchorX: titleLabel.leftAnchor, toAnchorX: contentView.leftAnchor, constant: 60)
//        titleLabel.leftAnchor.constraint(anchor: contentView.leftAnchor, constant: 60)
//        titleLabel.remake(left: contentView.leftAnchor, 60)
    }

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
            termLabel.text = "\(index + 1). \(data.terms[index])" // Default

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
