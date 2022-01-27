//
//  BaseScrollView.swift
//  UI
//
//  Created by Jmy on 2021/11/14.
//

import UIKit

final class BaseScrollView: UIScrollView {
    // MARK: - Initialization

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
