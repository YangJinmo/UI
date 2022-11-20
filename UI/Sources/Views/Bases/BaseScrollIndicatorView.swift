//
//  BaseScrollIndicatorView.swift
//  UI
//
//  Created by Jmy on 2022/11/20.
//

import UIKit

final class BaseScrollIndicatorView: BaseView {
    // MARK: - Properties

    var widthRatio: Double? {
        didSet {
//            guard let widthRatio = widthRatio else { return }
//            trackTintView.snp.remakeConstraints { make in
//                make.top.bottom.equalToSuperview()
//                make.width.equalToSuperview().multipliedBy(widthRatio)
//                make.left.greaterThanOrEqualToSuperview()
//                make.right.lessThanOrEqualToSuperview()
//                self.leftInsetConstraint = make.left.equalToSuperview().priority(999).constraint
//            }
        }
    }

    var leftOffsetRatio: Double? {
        didSet {
//            guard let leftOffsetRatio = leftOffsetRatio else { return }
//            leftInsetConstraint?.update(inset: leftOffsetRatio * bounds.width)
        }
    }

//    private var leftInsetConstraint: Constraint?

    // MARK: - UI Components

    private lazy var trackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white(57)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 1.5
        return view
    }()

    private lazy var trackTintView: UIView = {
        let view = UIView()
        view.backgroundColor = .white(216)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 1.5
        return view
    }()

    // MARK: - Initilize

    override func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: widthAnchor, constant: 54),
            heightAnchor.constraint(equalTo: heightAnchor, constant: 3),
        ])

        addSubview(trackView)
        trackView.addSubview(trackTintView)

        trackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trackView.topAnchor.constraint(equalTo: topAnchor),
            trackView.leftAnchor.constraint(equalTo: leftAnchor),
            trackView.rightAnchor.constraint(equalTo: rightAnchor),
            trackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        trackTintView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trackTintView.topAnchor.constraint(equalTo: trackView.topAnchor),
            trackTintView.bottomAnchor.constraint(equalTo: trackView.topAnchor),
            trackTintView.widthAnchor.constraint(equalTo: trackView.widthAnchor, constant: 54),
        ])

//        trackTintView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview()
//            make.width.equalToSuperview().multipliedBy(1.0 / 5.0)
//            make.left.greaterThanOrEqualToSuperview()
//            make.right.lessThanOrEqualToSuperview()
//            self.leftInsetConstraint = make.left.equalToSuperview().priority(999).constraint
//        }
    }
}
