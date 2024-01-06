//
//  BaseSlider.swift
//  UI
//
//  Created by Jmy on 2024/01/06.
//

import UIKit.UISlider

@IBDesignable
final class BaseSlider: TapSlider {
    @IBInspectable var trackHeight: CGFloat = 2

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect.size.height = trackHeight
        return rect
    }
}

import AVKit
import SwiftUI
import UIKit

struct VideoSlider: UIViewRepresentable {
    let player: AVPlayer
    @Binding var value: Float
    @Binding var isPaused: Bool
    @Binding var isTouched: Bool

    func makeUIView(context: Context) -> UISlider {
        let slider = BaseSlider()
        slider.thumbTintColor = .clear
        slider.minimumTrackTintColor = .gray
        slider.maximumTrackTintColor = .clear
        slider.setValue(0, animated: true)
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.sliderValueChanged(_:)), for: .valueChanged)
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.sliderTouchDown(_:_:)), for: .touchDown)
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.sliderTouchUpInside(_:_:)), for: .touchUpInside)
        return slider
    }

    func updateUIView(_ slider: UISlider, context: Context) {
        slider.setValue(value, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: VideoSlider

        init(_ parent: VideoSlider) {
            self.parent = parent
        }

        @objc func sliderValueChanged(_ slider: UISlider) {
            if slider.isTracking {
                parent.player.pause()

                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))

                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))

                slider.setValue(slider.value, animated: false)
            } else {
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))

                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))

                if !parent.isPaused {
                    parent.player.play()
                }

                slider.setValue(slider.value, animated: false)
            }
            
            "\(slider.value)".log()
        }

        @objc func sliderTouchDown(_ slider: UISlider, _ event: UIEvent) {
            // Called when the slider is touched down (begin tracking)
            "\(slider.value)".log()

            parent.isTouched = true
        }

        @objc func sliderTouchUpInside(_ slider: UISlider, _ event: UIEvent) {
            // Called when the slider is released (end tracking)
            "\(slider.value)".log()

            parent.isTouched = false
        }
    }
}

struct BaseSlider2: View {
    @State private var player = AVPlayer()
    @State private var progress: Float = 0
    @State private var isPaused = false
    @State private var isTouched = false
    
    var body: some View {
        VideoSlider(player: player, value: $progress, isPaused: $isPaused, isTouched: $isTouched)
    }
}

#Preview {
    BaseSlider2()
}
