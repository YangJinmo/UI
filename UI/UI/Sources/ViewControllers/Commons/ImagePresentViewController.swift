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

    private lazy var activityIndicatorView = BaseActivityIndicatorView()
    private lazy var imageView = BaseImageView()

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

        view.add(
            subview: activityIndicatorView,
            center: view
        )

        setTitleLabel(vcName)
        setImage(urlString: imageUrl)
    }

    // MARK: - Methods

    private func setImage(urlString: String) {
        guard let url: URL = urlString.url else { return }
        activityIndicatorView.startAnimating()

        DispatchQueue.global().async { [weak self] in
            do {
                let data: Data = try Data(contentsOf: url)

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if let image = UIImage(data: data) {
                        self.imageView.remakeAspectRatioConstraint(image)
                        self.imageView.image = image
                        self.activityIndicatorView.stopAnimating()
                    }
                }
            } catch {
                error.localizedDescription.log()
            }
        }
    }
}
