//
//  BaseViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/28.
//

import UIKit

class BaseViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    init(title: String) {
        super.init(nibName: nil, bundle: nil)

        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
