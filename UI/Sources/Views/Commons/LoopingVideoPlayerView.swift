//
//  LoopingVideoPlayerView.swift
//  UI
//
//  Created by Jmy on 2023/10/11.
//

import AVKit
import UIKit

fileprivate final class LoopingVideoPlayerView: UIView {
    var url: URL {
        didSet {
            print("LoopingVideoPlayer didSet: \(url.absoluteString)")
            configurePlayerItem()
        }
    }

    fileprivate var playerLayer = AVPlayerLayer()
    fileprivate var playerLooper: AVPlayerLooper?

    init(url: URL) {
        self.url = url

        super.init(frame: .zero)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        print("LoopingVideoPlayer configure: \(url.absoluteString)")

        let playerItem = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.player = queuePlayer

        layer.addSublayer(playerLayer)

        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)

        queuePlayer.play()
    }

    private func configurePlayerItem() {
        let playerItem = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = queuePlayer

        if let playerLooper = playerLooper {
            playerLooper.disableLooping()
        }

        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)

        queuePlayer.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        playerLayer.frame = bounds
    }
}
