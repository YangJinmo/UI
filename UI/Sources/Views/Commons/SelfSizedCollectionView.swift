//
//  SelfSizedCollectionView.swift
//  UI
//
//  Created by JMY on 2022/03/31.
//

import UIKit

final class SelfSizedCollectionView: BaseCollectionView {
    override func commonInit() {
        isScrollEnabled = false
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()

        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
