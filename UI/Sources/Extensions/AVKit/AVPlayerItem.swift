//
//  AVPlayerItem.swift
//  UI
//
//  Created by Jmy on 2023/03/21.
//

import AVKit

extension AVPlayerItem {
    var url: URL? {
        return (asset as? AVURLAsset)?.url
    }
}
