//
//  ImagePresentViewController.swift
//  UI
//
//  Created by Jmy on 2021/12/02.
//

import UIKit

class ImagePresentViewController: BasePresentViewController {
    // MARK: - Constants

    private let vcName = "ImagePresentViewController"

    // MARK: - Variables

    private var imageUrl: URL?

    // MARK: - Views

    private lazy var activityIndicatorView = BaseActivityIndicatorView()
    private lazy var imageView = BaseImageView()

    // MARK: - Initialization

    convenience init(imageUrl: URL) {
        self.init()

        self.imageUrl = imageUrl
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        hideDivider()
        setupScrollableStackView(imageView)

        view.add(
            activityIndicatorView,
            center: view
        )

        setTitleLabel(vcName)
        setImage(url: imageUrl)
    }

    // MARK: - Methods

    private func setImage(url: URL?) {
        guard let url = url else { return }
        activityIndicatorView.startAnimating()

        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.activityIndicatorView.stopAnimating()

                    guard let image = UIImage(data: data) else { return }
                    self.imageView.remakeAspectRatioConstraint(image)
                    self.imageView.image = image
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.toast(error.localizedDescription)
                    self.dismiss()
                }
            }
        }
    }
}
