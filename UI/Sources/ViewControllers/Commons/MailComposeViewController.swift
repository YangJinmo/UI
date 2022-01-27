//
//  MailComposeViewController.swift
//  UI
//
//  Created by Jmy on 2021/12/13.
//

import MessageUI

class MailComposeViewController: BaseNavigationViewController {
    // MARK: - Constants

    private let vcName = "MailComposeViewController"

    // MARK: - Views

    private lazy var sendEmailButton = UIButton("sendEmail")

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setTitleLabel(vcName)
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(
            sendEmailButton,
            heightConstant: 44,
            center: view
        )

        sendEmailButton.addTarget(self, action: #selector(sendEmailButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func sendEmailButtonTouched(_ sender: Any) {
        sendEmail()
    }

    func sendEmail() {
        let email = "didwlsah9@gmail.com"

        guard MFMailComposeViewController.canSendMail() else {
            UIPasteboard.general.string = email
            toast("메일 주소가 복사되었습니다.")
            return
        }

        let nickname = "getNickname"
        let emailTitle = "[이용 문의 및 제안] "
        let messageBody = "\n자세한 정보를 보내주시면 좀 더 빠른 해결이 가능해요!\n\n닉네임: \(nickname)\n앱버전: \(Bundle.appVersion)\n\n\n▶ 내용: \n\n\n\n\n\n\n"
        let toRecipents = [email]

        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setSubject(emailTitle)
        mailComposeViewController.setMessageBody(messageBody, isHTML: false)
        mailComposeViewController.setToRecipients(toRecipents)
        present(mailComposeViewController, animated: true)
    }
}

extension MailComposeViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            toast("메일 작성을 취소하였습니다.")
        case .saved:
            toast("메일을 저장하였습니다.")
        case .sent:
            toast("메일을 정상적으로 발송하였습니다.")
        case .failed:
            toast("메일을 발송을 실패하였습니다.")
        default: break
        }
        dismiss(animated: true)
    }
}
