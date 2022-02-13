//
//  RecommendedButton.swift
//  UI
//
//  Created by Jmy on 2022/02/13.
//

import UIKit

final class RecommendedButton: BaseButton {
    enum Recommended {
        case main
        case sub
    }

    var recommended: Recommended = .main {
        didSet {
            UIView.animate(withDuration: 0.25, animations: {
                self.setRecommended(self.recommended)
            })
        }
    }

    var isRecommended = true {
        didSet {
            UIView.animate(withDuration: 0.25, animations: {
                self.setIsRecommended(self.isRecommended)
            })
        }
    }

    // MARK: - Initialization

    override func initialize() {
        titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        layer.borderColor = .tint
        setHeight()
    }

    convenience init(_ text: String, recommended: Recommended = .main, isRecommended: Bool = true) {
        self.init(frame: .zero)

        setTitle(text, for: .normal)
        self.recommended = recommended
        self.isRecommended = isRecommended
        setIsRecommended(isRecommended)
    }

    // MARK: - Methods

    func setHeight(_ height: CGFloat = 46) {
        layer.masksToBounds = true
        layer.cornerRadius = height / 2

        Constraint.activate([
            heightAnchor.constraint(equalToConstant: height),
        ])
    }

    private func setIsRecommended(_ isRecommended: Bool) {
        if isRecommended {
            setRecommended(recommended)
        } else {
            setNon()
        }
    }

    private func setRecommended(_ recommended: Recommended) {
        switch recommended {
        case .main:
            setMain()
        case .sub:
            setSub()
        }
    }

    private func setMain() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .tint
        layer.borderWidth = 0
    }

    private func setSub() {
        setTitleColor(.tint, for: .normal)
        backgroundColor = .white
        layer.borderWidth = 1
    }

    private func setNon() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .white(201)
        layer.borderWidth = 0
    }
}
