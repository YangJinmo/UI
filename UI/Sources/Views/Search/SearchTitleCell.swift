//
//  SearchTitleCell.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class SearchTitleCell: BaseCollectionViewCell {
    // MARK: - Constants

    static let itemHeight: CGFloat = 56.0

    // MARK: - Variables

    private var timer: Timer?
    private var index = 0

    // MARK: - Views

    private lazy var titleLabel = UILabel.subtitle()
    private lazy var termLabel = UILabel.subtitle()
    private lazy var chevronButton: UIButton = {
        let button = UIButton()
        button.setImage(.chevronDown, for: .normal)
        button.setImage(.chevronUp, for: .selected)
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

    override func layoutSubviews() {
        super.layoutSubviews()

        "".log()
    }

    override func removeFromSuperview() {
        removeTimer()

        super.removeFromSuperview()

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
        search.isExpand.description.log()

        chevronButton.isSelected = search.isExpand
        titleLabel.text = search.title
        titleLabel.isHidden = search.isExpand

        if search.isExpand {
            removeTimer()
            index = 0
            termLabel.text = search.title
        } else {
            createTimer(search: search)
        }
    }

    private func setTermLabelText(search: Search, index: Int) {
        termLabel.text = "\(index + 1). \(search.terms[index])"
        "\(index + 1). \(search.terms[index])".log()
    }

    private func createTimer(search: Search) {
        removeTimer()

        setTermLabelText(search: search, index: index) // Default

        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(update), userInfo: search, repeats: true)
    }

    @objc private func update(_ timer: Timer) {
        guard let search = timer.userInfo as? Search else { return }

        setTermLabelText(search: search, index: index)
        index += 1

        if index == search.terms.count {
            index = 0
        }
    }

    public func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
}
