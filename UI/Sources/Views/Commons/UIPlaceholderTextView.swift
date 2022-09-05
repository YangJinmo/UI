//
//  UIPlaceholderTextView.swift
//  UI
//
//  Created by Jmy on 2022/09/05.
//

import UIKit

class UIPlaceholderTextView: UITextView {
    // MARK: - Public Properties

    /// Determines whether or not the placeholder text view contains text.
    open var isEmpty: Bool { return text.isEmpty }

    /// The string that is displayed when there is no other text in the placeholder text view. This value is `nil` by default.
    @IBInspectable open var placeholder: String? { didSet { setNeedsDisplay() } }

    /// The color of the placeholder. This property applies to the entire placeholder string. The default placeholder color is `UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)`.
    @IBInspectable open var placeholderColor: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0) { didSet { setNeedsDisplay() } }

    /// Max number of characters allowed by TextField.
    @IBInspectable public var maxNumberOfCharacters: Int = 0

    // MARK: - Superclass Properties

    override open var attributedText: NSAttributedString! { didSet { setNeedsDisplay() } }

    override open var bounds: CGRect { didSet { setNeedsDisplay() } }

    override open var contentInset: UIEdgeInsets { didSet { setNeedsDisplay() } }

    override open var font: UIFont? { didSet { setNeedsDisplay() } }

    override open var textAlignment: NSTextAlignment { didSet { setNeedsDisplay() } }

    override open var textContainerInset: UIEdgeInsets { didSet { setNeedsDisplay() } }

    override open var typingAttributes: [NSAttributedString.Key: Any] {
        didSet {
            guard isEmpty else {
                return
            }
            setNeedsDisplay()
        }
    }

    // MARK: - Object Lifecycle

    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInitializer()
    }

    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        commonInitializer()
    }

    // MARK: - Drawing

    override open func draw(_ rect: CGRect) {
        super.draw(rect)

        guard isEmpty else {
            return
        }
        guard let placeholder = placeholder else {
            return
        }

        var placeholderAttributes = typingAttributes

        if placeholderAttributes[NSAttributedString.Key.font] == nil {
            placeholderAttributes[NSAttributedString.Key.font] = typingAttributes[NSAttributedString.Key.font] ?? font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        if placeholderAttributes[NSAttributedString.Key.paragraphStyle] == nil {
            let typingParagraphStyle = typingAttributes[NSAttributedString.Key.paragraphStyle]
            if typingParagraphStyle == nil {
                let paragraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
                paragraphStyle.alignment = textAlignment
                paragraphStyle.lineBreakMode = textContainer.lineBreakMode
                placeholderAttributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
            } else {
                placeholderAttributes[NSAttributedString.Key.paragraphStyle] = typingParagraphStyle
            }
        }
        placeholderAttributes[NSAttributedString.Key.foregroundColor] = placeholderColor

        let paraph = NSMutableParagraphStyle()

        paraph.lineSpacing = 3

        placeholderAttributes[NSAttributedString.Key.paragraphStyle] = paraph

        let placeholderInsets = UIEdgeInsets(top: contentInset.top + textContainerInset.top,
                                             left: contentInset.left + textContainerInset.left + textContainer.lineFragmentPadding,
                                             bottom: contentInset.bottom + textContainerInset.bottom,
                                             right: contentInset.right + textContainerInset.right + textContainer.lineFragmentPadding)

        let placeholderRect = rect.inset(by: placeholderInsets)
        placeholder.draw(in: placeholderRect, withAttributes: placeholderAttributes)
    }

    // MARK: - Helper Methods

    fileprivate func commonInitializer() {
        contentMode = .topLeft
        maxNumberOfCharacters = 0
        NotificationCenter.default.addObserver(self, selector: #selector(UIPlaceholderTextView.handleTextViewTextDidChangeNotification(_:)), name: UITextView.textDidChangeNotification, object: self)
    }

    @objc internal func handleTextViewTextDidChangeNotification(_ notification: Notification) {
        guard let object = notification.object as? UIPlaceholderTextView, object === self else {
            return
        }
        if maxNumberOfCharacters != 0, text.count >= maxNumberOfCharacters {
//            text = text.substring(to: maxNumberOfCharacters)
            let index = text.index(text.startIndex, offsetBy: maxNumberOfCharacters)
            let subSequence = text[..<index]
            text = String(subSequence)
        }
        setNeedsDisplay()
    }
}
