//
//  AVPlayer.swift
//  UI
//
//  Created by Jmy on 2024/01/04.
//

import AVKit

extension AVPlayer {
    convenience init(url URL: URL) {
        let playerItem = AVPlayerItem(url: URL)
        playerItem.preferredForwardBufferDuration = 1

        self.init(playerItem: playerItem)

        automaticallyWaitsToMinimizeStalling = true
        playImmediately(atRate: 1)
    }

    func replaceCurrentItem(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        playerItem.preferredForwardBufferDuration = 1

        replaceCurrentItem(with: playerItem)

        automaticallyWaitsToMinimizeStalling = true
        playImmediately(atRate: 1)
    }

    var isPlaying: Bool {
        /// rate: 0 - 일시 정지
        /// rate: 1 - 일반 속도 재생
        return rate != 0 && error == nil
    }

    func addProgressObserver(action: @escaping ((Float) -> Void)) -> Any {
        let interval = CMTime(value: 1, timescale: 1)

        return addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] time in
            if let duration = self?.currentItem?.duration {
                let duration = CMTimeGetSeconds(duration), time = CMTimeGetSeconds(time)
                let progress = Float(time / duration)
                action(progress)
            }
        })
    }
}

extension AVPlayer.TimeControlStatus {
    var description: String {
        switch rawValue {
        case 0:
            return "paused"
        case 1:
            return "waiting"
        case 2:
            return "playing"
        default:
            return "default"
        }
    }
}
