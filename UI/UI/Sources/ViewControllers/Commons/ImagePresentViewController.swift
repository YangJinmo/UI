//
//  ImagePresentViewController.swift
//  UI
//
//  Created by Jmy on 2021/12/02.
//

import UIKit

class ImagePresentViewController: BasePresentViewController {
    // MARK: - Constants

    private let vcName: String = "IU"

    // MARK: - Variables

    private var imageUrl: String = ""

    // MARK: - Views

    private let imageView = BaseImageView(
        image: "https://t1.daumcdn.net/thumb/R600x0/?fname=http%3A%2F%2Ft1.daumcdn.net%2Fqna%2Fimage%2F4b035cdf8372d67108f7e8d339660479dfb41bbd".image
    )

    // MARK: - Initialization

    convenience init(imageUrl: String) {
        self.init()

        self.imageUrl = imageUrl
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        hideDivider()
        setupScrollableStackView(imageView)

        setTitleLabel(vcName)
        setImage(imageUrl.image)
    }

    // MARK: - Methods

    private func setImage(_ image: UIImage?) {
        guard let image: UIImage = image else { return }
        imageView.remakeAspectRatioConstraint(image)
        imageView.image = image
    }
}
