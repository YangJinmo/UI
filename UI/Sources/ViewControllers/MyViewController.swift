//
//  MyViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit
import UserNotifications

final class MyViewController: BaseTabViewController {
    // MARK: - Properties

    private enum Image {
        static let pencil = UIImage(systemName: "pencil")
        static let normal = UIImage(named: "imgNormal")
        static let disabled = UIImage.createThumbImage(size: 18, borderWidth: 0, fillColor: .white(127), strokeColor: .white(127))
        static let highlighted = UIImage(named: "imgHighlighted")
        static let singleTouched = UIImage(named: "imgSingleTouched")
    }

    private enum Font {
        static let nicknameButton = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    private let step: Float = 1
    private var isSingleTouched = false

    // MARK: - Views

    private lazy var emailButton = UIButton("Email")
    private lazy var alertButton = UIButton("Alert")
    private lazy var alertOptionButton = UIButton("AlertOption")
    private lazy var actionSheetButton = UIButton("ActionSheet")
    private lazy var modalButton = UIButton("Modal")
    private lazy var delegateButton = UIButton("Delegate")
    private lazy var bottomSheetButton = UIButton("BottomSheet")
    private lazy var pushMessageButton = UIButton("PushMessage")
    private lazy var shareButton = UIButton("Share")
    private lazy var nicknameButton: UIButton = {
        var configuration: UIButton.Configuration = .filled()
        configuration.title = "Edit Nickname"
        configuration.subtitle = "닉네임 수정"
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule
        configuration.image = Image.pencil
        configuration.imagePlacement = .leading
        configuration.imagePadding = 16
        configuration.baseBackgroundColor = .systemIndigo
        configuration.baseForegroundColor = .systemPink
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.sizeToFit()
        return button
    }()

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
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()

    // MARK: - View Life Cycle

    override convenience init() {
        self.init(title: "마이")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Methods

    private func setupViews() {
        setupScrollableStackView(
            emailButton,
            alertButton,
            alertOptionButton,
            actionSheetButton,
            modalButton,
            delegateButton,
            slider,
            bottomSheetButton,
            pushMessageButton,
            shareButton,
            nicknameButton
        )

        emailButton.height(56)
        alertButton.height(56)
        alertOptionButton.height(56)
        actionSheetButton.height(56)
        modalButton.height(56)
        delegateButton.height(56)

        slider.height(56)
        slider.left(equalTo: view.leftAnchor, constant: 32)

        bottomSheetButton.height(56)
        bottomSheetButton.left(equalTo: view.leftAnchor, constant: 32)
        pushMessageButton.height(56)
        shareButton.height(56)
        nicknameButton.height(56)

        nicknameButton.addTarget(self, action: #selector(nicknameButtonTouched(_:)), for: .touchUpInside)

        emailButton.addTarget(self, action: #selector(mailButtonTouched(_:)), for: .touchUpInside)
        alertButton.addTarget(self, action: #selector(alertButtonTouched(_:)), for: .touchUpInside)
        alertOptionButton.addTarget(self, action: #selector(alertOptionButtonTouched(_:)), for: .touchUpInside)
        actionSheetButton.addTarget(self, action: #selector(actionSheetButtonTouched(_:)), for: .touchUpInside)
        modalButton.addTarget(self, action: #selector(modalButtonTouched(_:)), for: .touchUpInside)

        delegateButton.addTarget(self, action: #selector(delegateButtonTouched(_:)), for: .touchUpInside)
        bottomSheetButton.addTarget(self, action: #selector(bottomSheetButtonTouched(_:)), for: .touchUpInside)

        bottomSheetButton.backgroundColor = .red
        bottomSheetButton.layer.addBorder(color: .label, width: 1)
//        bottomSheetButton.layer.addBorder([.top, .left], color: .label, width: 2)
        bottomSheetButton.layer.setShadow(x: 2, y: 2, blur: 2, alpha: 1)

        pushMessageButton.addTarget(self, action: #selector(pushMessageButtonTouched(_:)), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTouched), for: .touchUpInside)

        requestAuthorizationNotification()
    }

    private func requestAuthorizationNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert], completionHandler: { didAllow, error in
            if let error = error {
                "Error: \(error.localizedDescription)".log()
            } else {
                "didAllow: \(didAllow)".log()

                DispatchQueue.main.async {
                    UNUserNotificationCenter.current().delegate = self
                }
            }
        })
    }

    @objc private func nicknameButtonTouched(_ sender: Any) {
        pushViewController(TextViewController())
    }

    @objc private func mailButtonTouched(_ sender: Any) {
        pushViewController(MailComposeViewController())
    }

    @objc private func alertButtonTouched(_ sender: Any) {
        alert(
            title: "title",
            message: "message"
        ) { _ in
            "cancelHandler".log()
        } completion: {
            "completion".log()
        }
    }

    @objc private func alertOptionButtonTouched(_ sender: Any) {
        alertOption(
            title: "title",
            message: "message"
        ) { _ in
            "confirmHandler".log()
        } cancelHandler: { _ in
            "cancelHandler".log()
        } completion: {
            "completion".log()
        }
    }

    @objc private func actionSheetButtonTouched(_ sender: Any) {
        // actionSheetImplementedInUIViewControllerExtension()
        actionSheetImplementedInUIAlertControllerExtension()
    }

    private func actionSheetImplementedInUIViewControllerExtension() {
        actionSheet(
            title: "title",
            message: "message",
            actions:
            .default("default", { _ in
                "default".log()
            }),
            .destructive("destructive", { _ in
                "destructive".log()
            })
        ) { _ in
            "cancel".log()
        } completion: {
            "completion".log()
        }
    }

    private func actionSheetImplementedInUIAlertControllerExtension() {
        present(
            UIAlertController
                .actionSheet(title: "title", message: "message")
                .action(title: "default", style: .default) { _ in
                    "default".log()
                }
                .action(title: "destructive", style: .destructive) { _ in
                    "destructive".log()
                }
                .action(title: "취소", style: .cancel) { _ in
                    "cancel".log()
                }
        ) {
            "completion".log()
        }
    }

    @objc private func modalButtonTouched(_ sender: Any) {
        let vc = SearchViewController()

        /// https://sarunw.com/posts/bottom-sheet-in-ios-15-with-uisheetpresentationcontroller/
        /// https://sarunw.com/posts/modality-changes-in-ios13/
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }

        let medium = UIBarButtonItem(title: "Medium", primaryAction: .init(handler: { _ in
            if let sheet = nav.sheetPresentationController {
                sheet.animateChanges {
                    sheet.detents = [.medium()]
                }
            }
        }))
        let large = UIBarButtonItem(title: "Large", primaryAction: .init(handler: { _ in
            if let sheet = nav.sheetPresentationController {
                sheet.animateChanges {
                    sheet.detents = [.large()]
                }
            }
        }))
        vc.navigationItem.leftBarButtonItem = medium
        vc.navigationItem.rightBarButtonItem = large

        present(nav)
    }

    @objc private func delegateButtonTouched(_ sender: Any) {
        present(DelegateViewController(delegate: self))
    }

    @objc private func sliderValueDidChange(_ sender: UISlider!) {
        sender.value = round(sender.value / step) * step
        // score = Int(sender.value)

        if isSingleTouched == false {
            isSingleTouched = true

            slider.setThumbImage(Image.singleTouched, for: .normal)
        }
    }

    @objc private func bottomSheetButtonTouched(_ sender: Any) {
        let vc = BottomSheetViewController()
        vc.setTitleLabel("정렬")
        vc.bind(selectedSort: selectedSort)
        vc.bind(didSelectItemAt: didSelectItemAt)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }

    @objc private func pushMessageButtonTouched(_ sender: Any) {
        "".log()

        let content = UNMutableNotificationContent()
        content.title = "This is title"
        content.subtitle = "This is Subtitle"
        content.body = "This is Body"
        content.badge = 1

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    @objc private func shareButtonTouched() {
        guard let url = "https://www.apple.com/".toURL else { return }
        showShareSheet(url: url)
    }

    private func showShareSheet(url: URL) {
        let activityViewController = UIActivityViewController(
            activityItems: [url],
            applicationActivities: [SafariActivity()]
        )
        activityViewController.popoverPresentationController?.sourceView = view
        activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, activityItems: [Any]?, error: Error?) in
            if completed {
                print("share success \(activityType?.rawValue ?? "")")
            } else {
                print("share cancel \(activityType?.rawValue ?? "")")
            }

            if let error = error {
                print("Oh no! Got an error! \(error.localizedDescription)")
            }

            guard let activityItems = activityItems else { return }

            for activityItem in activityItems {
                print("activityItem: \(activityItem)")
            }
        }

        /// 공유하기 기능 중 제외할 기능이 있을 때 사용
//        activityViewController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        present(activityViewController, animated: true)
    }

    private var selectedSort = Sort.dateOrder

    private func didSelectItemAt(selectedSort: Sort) {
        self.selectedSort = selectedSort
    }
}

extension MyViewController: ChangeUIDelegate {
    func changeUI() {
        contentView.backgroundColor = .random()

        toast("UI가 변경되었습니다.", bottom: true)
    }
}

extension MyViewController: UNUserNotificationCenterDelegate {
    // To display notifications when app is running in foreground

    // 앱이 foreground에 있을 때. 즉 앱안에 있어도 push알림을 받게 해줍니다.
    // viewDidLoad()에 UNUserNotificationCenter.current().delegate = self를 추가해주는 것을 잊지마세요.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge, .list, .banner])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        present(settingsViewController, animated: true, completion: nil)
    }
}
