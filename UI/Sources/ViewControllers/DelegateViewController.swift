//
//  DelegateViewController.swift
//  UI
//
//  Created by Jmy on 2021/12/22.
//

import UIKit

protocol ChangeUIDelegate: AnyObject {
    func changeUI()
}

final class DelegateViewController: BaseTabViewController {
    // MARK: - Properties

    weak var delegate: ChangeUIDelegate?

    // MARK: - Views

    private lazy var changeButton = UIButton("Change", .title)

    // MARK: - View Life Cycle

    init(delegate: ChangeUIDelegate) {
        self.delegate = delegate

        super.init(title: "Delegate")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(
            changeButton,
            heightConstant: 44,
            center: view
        )

        changeButton.addTarget(self, action: #selector(changeButtonTouched(_:)), for: .touchUpInside)

        addDismissButton()
    }

    @objc private func changeButtonTouched(_ sender: Any) {
        delegate?.changeUI()
        dismiss()
    }
}
