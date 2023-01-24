//
//  SearchCollectionReusableView.swift
//  UI
//
//  Created by Jmy on 2023/01/23.
//

import UIKit

final class SearchCollectionReusableView: BaseCollectionReusableView {
    static let itemHeight: CGFloat = 44

    private enum Image {
        static let pencil = UIImage(systemName: "pencil")
        static let normal = UIImage(named: "imgNormal")
        static let disabled = UIImage.createThumbImage(size: 18, borderWidth: 0, fillColor: .white(127), strokeColor: .white(127))
        static let highlighted = UIImage(named: "imgHighlighted")
        static let singleTouched = UIImage(named: "imgSingleTouched")
    }

    private let step: Float = 1
    private var isSingleTouched = false

    private lazy var slider: TapSlider = {
        let slider = TapSlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.tintColor = .rgb(r: 234, g: 57, b: 92)
//        slider.thumbTintColor = .rgb(r: 234, g: 57, b: 92)
        slider.setThumbImage(Image.normal, for: .normal)
        slider.setThumbImage(Image.highlighted, for: .highlighted)
        slider.setThumbImage(Image.disabled, for: .disabled)
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        return slider
    }()

    override func commonInit() {
        backgroundColor = .systemGroupedBackground

        add(slider)

        slider.top(equalTo: topAnchor)
        slider.left(equalTo: leftAnchor, constant: 32)
        slider.right(equalTo: rightAnchor, constant: 32)
        slider.bottom(equalTo: bottomAnchor)
    }

    @objc private func sliderValueDidChange(_ sender: UISlider!) {
        sender.value = round(sender.value / step) * step
        // score = Int(sender.value)

        if isSingleTouched == false {
            isSingleTouched = true

            slider.setThumbImage(Image.singleTouched, for: .normal)
        }
    }
}
