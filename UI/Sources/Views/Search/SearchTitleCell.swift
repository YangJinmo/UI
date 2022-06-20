//
//  SearchTitleCell.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class SearchTitleCell: BaseCollectionViewCell {
    // MARK: - Constants

    static let itemHeight: CGFloat = 76.0

    private enum Image {
        static let chevronDownImage = UIImage(systemName: "chevron.down")
        static let chevronUpImage = UIImage(systemName: "chevron.up")
    }

    // MARK: - Variables

    private var timer: Timer?
    private var index = 0

    // MARK: - Views

    private lazy var titleLabel = UILabel.makeForSubtitle()
    private lazy var termLabel = UILabel.makeForSubtitle()
    private lazy var chevronButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.chevronDownImage, for: .normal)
        button.setImage(Image.chevronUpImage, for: .selected)
        button.tintColor = .label
        button.isUserInteractionEnabled = false
        return button
    }()

    // MARK: - View Life Cycle

    override class func awakeFromNib() {
        super.awakeFromNib()

        "".log()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        "".log()
    }

    deinit {
        Self.identifier.log()
    }

    override func commonInit() {
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
            chevronButton,
            right: contentView.rightAnchor, 36,
            centerY: contentView
        )

        contentView.addBottomBorder()

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

    // MARK: - Methods

    // TODO: Add Timer in model
    public func bind(search: Search) {
        chevronButton.isSelected = search.isExpand
        titleLabel.text = search.title
        titleLabel.isHidden = search.isExpand

        if search.isExpand == true {
            removeTimer()
            index = 0
            termLabel.text = search.title
        } else {
            createTimer(search: search)
        }
    }

    private func setupTermLabel(search: Search, index: Int) {
        termLabel.text = "\(index + 1). \(search.terms[index])"
        "\(index + 1). \(search.terms[index])".log()
    }

    private func createTimer(search: Search) {
        removeTimer()

        guard timer == nil else {
            return
        }
        setupTermLabel(search: search, index: index) // Default

        timer = Timer.scheduledTimer(
            withTimeInterval: 2.0,
            repeats: true,
            block: { [weak self] _ in
                guard let self = self else {
                    return
                }

                self.setupTermLabel(search: search, index: self.index)
                self.index += 1

                if self.index == search.terms.count {
                    self.index = 0
                }
            }
        )
    }

    public func removeTimer() {
        guard timer != nil else {
            return
        }
        timer?.invalidate()
        timer = nil
    }
}
