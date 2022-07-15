//
//  ImagePresentViewController.swift
//  UI
//
//  Created by Jmy on 2021/12/02.
//

import UIKit

final class ImagePresentViewController: BaseTabViewController {
    // MARK: - Properties

    private var imageUrl: URL?

    // MARK: - Views

    private lazy var activityIndicatorView = BaseActivityIndicatorView()
    private lazy var imageView = BaseImageView()

    // MARK: - Initialization

    convenience init(imageUrl: URL) {
        self.init(title: "ImagePresentViewController")

        self.imageUrl = imageUrl
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Methods

    private func setupViews() {
        setupScrollableStackView(imageView)

        imageView.add(
            activityIndicatorView,
            center: imageView
        )

        setImage(url: imageUrl)

        addDismissButton()
    }

    private func setImage(url: URL?) {
        guard let url = url else {
            return
        }

        activityIndicatorView.startAnimating()

        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }

                    self.activityIndicatorView.stopAnimating()

                    guard let image = UIImage(data: data) else {
                        return
                    }

                    self.imageView.remakeAspectRatioConstraint(image)
                    self.imageView.image = image
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }

                    self.toast(error.localizedDescription)
                    self.dismiss()
                }
            }
        }
    }
}
