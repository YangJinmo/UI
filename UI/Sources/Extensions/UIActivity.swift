//
//  UIActivity.swift
//  UI
//
//  Created by JMY on 2022/06/10.
//

import UIKit.UIActivity

extension UIActivity.ActivityType {
    static let openInSafari = UIActivity.ActivityType("openInSafari")
    static let addToiCloudDrive = UIActivity.ActivityType("com.apple.CloudDocsUI.AddToiCloudDrive")
    static let postToLinkedIn = UIActivity.ActivityType("com.linkedin.LinkedIn.ShareExtension")
    static let postToSlack = UIActivity.ActivityType("com.tinyspeck.chatlyio.share")
}
