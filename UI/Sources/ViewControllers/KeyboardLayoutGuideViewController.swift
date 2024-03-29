//
//  KeyboardLayoutGuideViewController.swift
//  UI
//
//  Created by Jmy on 2023/01/14.
//

import UIKit

final class KeyboardLayoutGuideViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Setting the keyboardLayoutGuide to follow undocked keyboards
        /// - Tag: followsUndockedKeyboard
        // This is necessary to allow the various edge constraints to engage.
        view.keyboardLayoutGuide.followsUndockedKeyboard = true

        createTrackingConstraints()
    }

    func createTrackingConstraints() {
        let imageView = makeTitleAndImage()

        let editView = makeControlsView()
        view.addSubview(editView)

        // When docking, tie the imageView to the keyboardLayoutGuide's
        // top anchor, so that it shrinks and always fits above the keyboard,
        // and put the edit view at the trailing edge, similar to where an
        // inputAccessoryView sits.
        let keyboardToImageView = view.keyboardLayoutGuide.topAnchor.constraint(
            greaterThanOrEqualToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1.0)
        keyboardToImageView.identifier = "keyboardToImageView"

        let editViewToDockedKeyboardTrailing = view.keyboardLayoutGuide.trailingAnchor.constraint(equalTo: editView.trailingAnchor)
        editViewToDockedKeyboardTrailing.identifier = "editViewToDockedKeyboardTrailing"

        let nearBottomConstraints = [keyboardToImageView, editViewToDockedKeyboardTrailing]
        view.keyboardLayoutGuide.setConstraints(nearBottomConstraints, activeWhenNearEdge: .bottom)

        /// Create constraints that change when the keyboard is awayFrom multiple edges.
        /// - Tag: MultipleEdges
        // When the keyboard is away from the leading, trailing, and bottom,
        // this centers the edit view on top of the keyboard. The following
        // code mostly applies to the floating keyboard in the middle of the
        // screen. When the keyboard isn't near the leading or trailing
        // edge, the constraints center the image.

        let editCenterXToKeyboard = view.keyboardLayoutGuide.centerXAnchor.constraint(equalTo: editView.centerXAnchor)
        editCenterXToKeyboard.identifier = "editCenterXToKeyboard"
        let centeredImage = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centeredImage.identifier = "centeredImage"

        view.keyboardLayoutGuide.setConstraints([editCenterXToKeyboard], activeWhenAwayFrom: [.leading, .trailing, .bottom])
        view.keyboardLayoutGuide.setConstraints([centeredImage], activeWhenAwayFrom: [.leading, .trailing])

        /// Using tracking constraints to move the imageView to the opposite side of the screen from the keyboard.
        /// - Tag: UsingTrackingConstraintsHorizontal
        // When the keyboard is at the trailing side, this ties
        // the edit view to the trailing edge of the keyboard, and moves the image
        // view over so that the keyboard is less likely to cover it.
        let imageViewToLeading = imageView.leadingAnchor.constraint(
            equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1.0)
        imageViewToLeading.identifier = "imageViewToLeading"

        let editViewToUndockedKeyboardTrailing = view.keyboardLayoutGuide.trailingAnchor.constraint(
            equalToSystemSpacingAfter: editView.trailingAnchor, multiplier: 1.0)
        editViewToUndockedKeyboardTrailing.identifier = "editViewToUndockedKeyboardTrailing"

        let nearTrailingConstraints = [editViewToUndockedKeyboardTrailing, imageViewToLeading]
        view.keyboardLayoutGuide.setConstraints(nearTrailingConstraints, activeWhenNearEdge: .trailing)

        // This is the same as trailing, except in the other direction.
        let editViewToKeyboardLeading = editView.leadingAnchor.constraint(
            equalToSystemSpacingAfter: view.keyboardLayoutGuide.leadingAnchor, multiplier: 1.0)
        editViewToKeyboardLeading.identifier = "editViewToKeyboardLeading"
        let imageViewToTrailing = view.safeAreaLayoutGuide.trailingAnchor.constraint(
            equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 1.0)
        imageViewToTrailing.identifier = "imageViewToTrailing"

        let nearLeadingConstraints = [editViewToKeyboardLeading, imageViewToTrailing]
        view.keyboardLayoutGuide.setConstraints(nearLeadingConstraints, activeWhenNearEdge: .leading)

        /// Using tracking constraints to move the editView from the keyboardLayoutGuide to the safeAreaLayoutGuide.
        /// - Tag: UsingTrackingConstraintsVertical
        // When the keyboard isn't near the top, tie the edit view to the
        // keyboard layout guide. The keyboard layout guide deactivates the
        // editViewOnKeyboard constraint when the keyboard is near the top.
        let editViewOnKeyboard = view.keyboardLayoutGuide.topAnchor.constraint(equalTo: editView.bottomAnchor)
        editViewOnKeyboard.identifier = "editViewOnKeyboard"
        view.keyboardLayoutGuide.setConstraints([editViewOnKeyboard], activeWhenAwayFrom: .top)

        // When the keyboard is near the top, tie the edit view to the
        // safeAreaLayoutGuide's bottom so that it doesn't go offscreen.
        let editViewOnBottom = view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: editView.bottomAnchor)
        editViewOnBottom.identifier = "editViewOnBottom"
        view.keyboardLayoutGuide.setConstraints([editViewOnBottom], activeWhenNearEdge: .top)
    }

    func makeTitleAndImage() -> UIImageView {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.text = "Succulent garden"
        titleLabel.textAlignment = .natural
        view.addSubview(titleLabel)

        let image = #imageLiteral(resourceName: "imgNormal")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        let imageSize = image.size

        // This is a sizing ratio constraint to make sure the image keeps its original
        // ratio.
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: imageSize.width / imageSize.height).isActive = true

        // Set the compression resistance lower to allow the image to
        // compress smaller than its intrinsic size before allowing that to
        // happen to other views.
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        // These constraints are constant, no matter where the keyboard is,
        // whether docked or undocked.
        let sharedConstraints = [
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2.0),
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0),
            imageView.widthAnchor.constraint(lessThanOrEqualTo: view.readableContentGuide.widthAnchor, multiplier: 1.0),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.leadingAnchor, multiplier: 1.0),
        ]
        NSLayoutConstraint.activate(sharedConstraints)

        return imageView
    }

    func makeControlsView() -> UIView {
        // None of these controls do anything, but you can replace them with
        // actual functional buttons.

        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Image description"

        let verticalStack = UIStackView()
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.spacing = 10.0
        verticalStack.distribution = .fill
        verticalStack.axis = .vertical
        verticalStack.alignment = .center
        verticalStack.addArrangedSubview(textField)

        let controlsView = UIStackView()
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        controlsView.spacing = 30.0
        controlsView.distribution = .equalSpacing
        controlsView.axis = .horizontal
        controlsView.alignment = .center
        controlsView.tintColor = UIColor.systemPurple

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20)

        controlsView.addArrangedSubview(UIImageView(image: UIImage(systemName: "rotate.right", withConfiguration: imageConfig)))
        controlsView.addArrangedSubview(UIImageView(image: UIImage(systemName: "rotate.left", withConfiguration: imageConfig)))
        controlsView.addArrangedSubview(UIImageView(image: UIImage(systemName: "crop", withConfiguration: imageConfig)))
        controlsView.addArrangedSubview(UIImageView(image: UIImage(systemName: "slider.vertical.3", withConfiguration: imageConfig)))
        controlsView.addArrangedSubview(UIImageView(image: UIImage(systemName: "character.textbox", withConfiguration: imageConfig)))

        verticalStack.addArrangedSubview(controlsView)

        textField.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 1.0).isActive = true

        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.systemGroupedBackground
        backgroundView.addSubview(verticalStack)
        backgroundView.layer.cornerRadius = 10.0

        let backgroundConstraints = [
            verticalStack.topAnchor.constraint(equalToSystemSpacingBelow: backgroundView.topAnchor, multiplier: 2.0),
            verticalStack.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 2.0),
            backgroundView.bottomAnchor.constraint(equalToSystemSpacingBelow: verticalStack.bottomAnchor, multiplier: 1.0),
            backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: verticalStack.trailingAnchor, multiplier: 2.0),
        ]
        NSLayoutConstraint.activate(backgroundConstraints)

        return backgroundView
    }
}
