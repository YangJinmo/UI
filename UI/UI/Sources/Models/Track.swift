//
//  Track.swift
//  UI
//
//  Created by Jmy on 2021/12/29.
//

import Foundation.NSURL

class Track {
    let artist: String
    let index: Int
    let name: String
    let previewURL: URL

    var downloaded = false

    init(name: String, artist: String, previewURL: URL, index: Int) {
        self.name = name
        self.artist = artist
        self.previewURL = previewURL
        self.index = index
    }
}
