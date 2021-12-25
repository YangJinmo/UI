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

    private enum Font {
        static let basicButton: UIFont = .systemFont(ofSize: 16, weight: .semibold)
    }

    private let vcName: String = "Delegate"
    
    // MARK: - Initialization

    init(delegate: ChangeUIDelegate) {
        self.delegate = delegate

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views

    private let changeButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Change", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Font.basicButton
        return button
    }()

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
