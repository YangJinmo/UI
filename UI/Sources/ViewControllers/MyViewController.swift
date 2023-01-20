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

    private var searches: [Search] = [
        Search(
            isExpand: false,
            title: "Alert",
            terms: ["캠핑", "가방", "고양이", "건전지", "오미자"]
        ),
        Search(
            isExpand: false,
            title: "Views",
            terms: ["충전기", "강아지", "개구리", "두꺼비", "아이유"]
        ),
        Search(
            isExpand: false,
            title: "Etcs",
            terms: ["보충제", "고구마", "헬스장", "런닝머신", "다이어트"]
        ),
    ]

    // MARK: - Views

    private lazy var collectionView: BaseCollectionView = {
        let collectionView = BaseCollectionView(layout: flowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchTitleCell.self)
        collectionView.register(SearchTermCell.self)
        return collectionView
    }()

    private lazy var emailButton = UIButton("Email")
    private lazy var alertButton = UIButton("Alert")
    private lazy var alertOptionButton = UIButton("AlertOption")
    private lazy var actionSheetButton = UIButton("ActionSheet")
    private lazy var modalButton = UIButton("Modal")
    private lazy var delegateButton = UIButton("Delegate")
    private lazy var bottomSheetButton = UIButton("BottomSheet")
    private lazy var pushMessageButton = UIButton("PushMessage")
    private lazy var shareButton = UIButton("Share")
    private lazy var transactionButton = UIButton("CATransaction")
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
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        return slider
    }()

    // MARK: - Creating a view controller

    override convenience init() {
        self.init(title: "마이")
    }

    // MARK: - Managing the view

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        requestAuthorizationNotification()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

//        removeAllCells()
    }

    // MARK: - Responding to environment changes

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }

    // MARK: - Methods

    private func setupViews() {
//        contentView.addSubviews(collectionView)

//        contentView.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
//        contentView.addConstraintsWithFormat("V:|[v0]|", views: collectionView)

//        collectionView.edges()
//        collectionView.edges(equalTo: contentView)

        contentView.add(
            collectionView,
            edges: contentView
        )

//        setupScrollableStackView(
//            emailButton,
//            alertButton,
//            alertOptionButton,
//            actionSheetButton,
//            modalButton,
//            delegateButton,
//            slider,
//            bottomSheetButton,
//            pushMessageButton,
//            shareButton,
//            transactionButton,
//            nicknameButton
//        )

//        emailButton.height(44)
//        alertButton.height(44)
//        alertOptionButton.height(44)
//        actionSheetButton.height(44)
//        modalButton.height(44)
//        delegateButton.height(44)
//
//        slider.height(44)
//        slider.left(equalTo: view.leftAnchor, constant: 32)
//
//        bottomSheetButton.height(44)
//        bottomSheetButton.left(equalTo: view.leftAnchor, constant: 32)
//        pushMessageButton.height(44)
//        shareButton.height(44)
//        transactionButton.height(44)
//        nicknameButton.height(44)
//
//        nicknameButton.addTarget(self, action: #selector(nicknameButtonTouched), for: .touchUpInside)
//
//        emailButton.addTarget(self, action: #selector(mailButtonTouched), for: .touchUpInside)
//        alertButton.addTarget(self, action: #selector(alertButtonTouched), for: .touchUpInside)
//        alertOptionButton.addTarget(self, action: #selector(alertOptionButtonTouched), for: .touchUpInside)
//        actionSheetButton.addTarget(self, action: #selector(actionSheetButtonTouched), for: .touchUpInside)
//        modalButton.addTarget(self, action: #selector(modalButtonTouched), for: .touchUpInside)
//
//        delegateButton.addTarget(self, action: #selector(delegateButtonTouched), for: .touchUpInside)
//        bottomSheetButton.addTarget(self, action: #selector(bottomSheetButtonTouched), for: .touchUpInside)
//
//        bottomSheetButton.backgroundColor = .red
//        bottomSheetButton.layer.addBorder(color: .label, width: 1)
////        bottomSheetButton.layer.addBorder([.top, .left], color: .label, width: 2)
//        bottomSheetButton.layer.setShadow(x: 2, y: 2, blur: 2, alpha: 1)
//
//        pushMessageButton.addTarget(self, action: #selector(pushMessageButtonTouched), for: .touchUpInside)
//        shareButton.addTarget(self, action: #selector(shareButtonTouched), for: .touchUpInside)
//        transactionButton.addTarget(self, action: #selector(transactionButtonTouched), for: .touchUpInside)
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

    @objc private func nicknameButtonTouched() {
        pushViewController(TextViewController())
    }

    @objc private func mailButtonTouched() {
        pushViewController(MailComposeViewController())
    }

    @objc private func alertButtonTouched() {
        alert(
            title: "title",
            message: "message"
        ) { _ in
            "cancelHandler".log()
        } completion: {
            "completion".log()
        }
    }

    @objc private func alertOptionButtonTouched() {
        alertTwoOptions(
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

    @objc private func actionSheetButtonTouched() {
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

    @objc private func modalButtonTouched() {
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

    @objc private func delegateButtonTouched() {
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

    @objc private func bottomSheetButtonTouched() {
        let vc = BottomSheetViewController()
        vc.setTitleLabel("정렬")
        vc.bind(selectedSort: selectedSort)
        vc.bind(didSelectItemAt: didSelectItemAt)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }

    private var selectedSort = Sort.dateOrder

    private func didSelectItemAt(selectedSort: Sort) {
        self.selectedSort = selectedSort
    }

    @objc private func pushMessageButtonTouched() {
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

    @objc private func transactionButtonTouched() {
        pushViewController(CATransactionViewController())
    }

    private func removeAllCells() {
        for section in 0 ..< collectionView.numberOfSections {
            section.description.log()

            let indexPath = IndexPath(item: 0, section: section)
            removeCell(indexPath: indexPath)
        }
    }

    private func removeCell(indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SearchTitleCell {
            cell.removeFromSuperview()
        }
        indexPath.description.log()
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

// MARK: - UICollectionViewDataSource

extension MyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let search = searches[section]

        if search.isExpand {
            return search.terms.count + 1
        } else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let search = searches[indexPath.section]

        switch indexPath.item {
        case 0:
            let cell: SearchTitleCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.bind(search: search)
            return cell
        default:
            let cell: SearchTermCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.bind(
                rank: indexPath.item,
                term: search.terms[indexPath.item - 1]
            )
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            removeCell(indexPath: indexPath)

            searches[indexPath.section].isExpand.toggle()

            let sections = IndexSet(integer: indexPath.section)
            collectionView.reloadSections(sections)
        default:
            searches[indexPath.section].terms[indexPath.item - 1].log()

//            nicknameButton.addTarget(self, action: #selector(nicknameButtonTouched), for: .touchUpInside)
//
//            emailButton.addTarget(self, action: #selector(mailButtonTouched), for: .touchUpInside)
//            alertButton.addTarget(self, action: #selector(alertButtonTouched), for: .touchUpInside)
//            alertOptionButton.addTarget(self, action: #selector(alertOptionButtonTouched), for: .touchUpInside)
//            actionSheetButton.addTarget(self, action: #selector(actionSheetButtonTouched), for: .touchUpInside)
//            modalButton.addTarget(self, action: #selector(modalButtonTouched), for: .touchUpInside)
//
//            delegateButton.addTarget(self, action: #selector(delegateButtonTouched), for: .touchUpInside)
//            bottomSheetButton.addTarget(self, action: #selector(bottomSheetButtonTouched), for: .touchUpInside)
//
//            pushMessageButton.addTarget(self, action: #selector(pushMessageButtonTouched), for: .touchUpInside)
//            shareButton.addTarget(self, action: #selector(shareButtonTouched), for: .touchUpInside)
//            transactionButton.addTarget(self, action: #selector(transactionButtonTouched), for: .touchUpInside)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return itemSize(in: collectionView, height: SearchTitleCell.itemHeight)
        default:
            return itemSize(in: collectionView, height: SearchTermCell.itemHeight)
        }
    }
}

// MARK: - FlowLayoutMetric

extension MyViewController: FlowLayoutMetric {
    var numberOfItemForRow: CGFloat {
        1.0
    }

    var sectionInset: UIEdgeInsets {
        .uniform(size: 0.0)
    }

    var minimumLineSpacing: CGFloat {
        1.0
    }

    var minimumInteritemSpacing: CGFloat {
        0.0
    }
}
