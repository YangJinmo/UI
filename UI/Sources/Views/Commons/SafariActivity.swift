//
//  SafariActivity.swift
//  UI
//
//  Created by JMY on 2022/06/10.
//

import UIKit.UIActivity

final class SafariActivity: UIActivity {
    var url: URL?

    var activityCategory: UIActivity.Category = .action

    override var activityType: UIActivity.ActivityType {
        .openInSafari
    }

    override var activityTitle: String? {
        "Open in Safari"
    }

    override var activityImage: UIImage? {
        UIImage(systemName: "safari")?.applyingSymbolConfiguration(.init(scale: .large))
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        activityItems.contains { $0 is URL ? UIApplication.shared.canOpenURL($0 as! URL) : false }
    }

    override func prepare(withActivityItems activityItems: [Any]) {
        url = activityItems.first { $0 is URL ? UIApplication.shared.canOpenURL($0 as! URL) : false } as? URL
    }

    override func perform() {
        if let url = url {
            UIApplication.shared.open(url)
        }
        activityDidFinish(true)
    }
}
