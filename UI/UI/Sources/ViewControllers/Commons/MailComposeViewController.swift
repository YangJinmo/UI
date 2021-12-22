//
//  MailComposeViewController.swift
//  UI
//
//  Created by Jmy on 2021/12/13.
//

import MessageUI

class MailComposeViewController: BaseNavigationViewController {
    
    private struct Font {
        static let basicButton: UIFont = .systemFont(ofSize: 16, weight: .semibold)
    }

    private let vcName: String = "MailCompose"
    
    // MARK: - Views

    private let sendEmailButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("sendEmail", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Font.basicButton
        return button
    }()

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
        let email: String = "didwlsah9@gmail.com"

        guard MFMailComposeViewController.canSendMail() else {
            UIPasteboard.general.string = email
            toast("메일 주소가 복사되었습니다.")
            return
        }

        let nickname: String = "getNickname"
        let emailTitle: String = "[이용 문의 및 제안] "
        let messageBody: String = "\n자세한 정보를 보내주시면 좀 더 빠른 해결이 가능해요!\n\n닉네임: \(nickname)\n앱버전: \(Bundle.appVersion)\n\n\n▶ 내용: \n\n\n\n\n\n\n"
        let toRecipents: [String] = [email]

        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        present(mc, animated: true)
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
