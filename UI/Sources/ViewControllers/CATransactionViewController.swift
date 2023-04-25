//
//  CATransactionViewController.swift
//  UI
//
//  Created by Jmy on 2023/01/09.
//

import UIKit

final class CATransactionViewController: BaseTabViewController {
    private lazy var myView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("애니메이션", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        return button
    }()

    override convenience init() {
        self.init(title: "CATransactionViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.backgroundColor = .systemGray4

        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])

        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            myView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            myView.widthAnchor.constraint(equalToConstant: 200),
            myView.heightAnchor.constraint(equalToConstant: 200),
        ])

        addPopButton()
    }

    @objc private func didTapButton() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.button.setTitle("애니메이션 완료!", for: .normal)
        }

        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = CGColor.random()
        animation.toValue = CGColor.random()
        animation.duration = 3
        animation.repeatCount = 1
        myView.layer.add(animation, forKey: "myAnimation")

        CATransaction.commit() // Commits outer transaction
    }
}
