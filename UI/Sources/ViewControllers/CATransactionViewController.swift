//
//  CATransactionViewController.swift
//  UI
//
//  Created by Jmy on 2023/01/09.
//

import UIKit

final class CATransactionViewController: UIViewController {
    private lazy var myView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        return view
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("애니메이션", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        return button
    }()

    private var randomColor: UIColor {
        UIColor(red: drand48().f, green: drand48().f, blue: drand48().f, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4

        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myView.widthAnchor.constraint(equalToConstant: 200),
            myView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    @objc private func didTapButton() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.button.setTitle("애니메이션 완료!", for: .normal)
        }

        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = randomColor.cgColor
        animation.toValue = randomColor.cgColor
        animation.duration = 3
        animation.repeatCount = 1
        myView.layer.add(animation, forKey: "myAnimation")

        CATransaction.commit() // Commits outer transaction
    }
}
