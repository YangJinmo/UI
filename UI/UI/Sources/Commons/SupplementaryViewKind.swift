//
//  SupplementaryViewKind.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

public enum SupplementaryViewKind: String {
    case header, footer
    
    public init?(rawValue: String) {
        switch rawValue {
        case UICollectionView.elementKindSectionHeader: self = .header
        case UICollectionView.elementKindSectionFooter: self = .footer
        default: return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}
