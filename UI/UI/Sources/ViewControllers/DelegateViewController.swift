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

final class DelegateViewController: BasePresentViewController {
    weak var delegate: ChangeUIDelegate?

    // MARK: - Constants

    private let vcName = "Delegate"

    // MARK: - Initialization

    init(delegate: ChangeUIDelegate) {
        self.delegate = delegate

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views

    private lazy var changeButton = UIButton.makeForBasic("Change")

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setTitleLabel(vcName)
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(
            changeButton,
            heightConstant: 44,
            center: view
        )

        changeButton.addTarget(self, action: #selector(changeButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func changeButtonTouched(_ sender: Any) {
        delegate?.changeUI()
        dismiss()
    }
}
