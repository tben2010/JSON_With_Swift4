//
//  Video.swift
//  JsonWithSwift4
//
//  Created by tben on 03.08.17.
//  Copyright © 2017 tben. All rights reserved.
//

import Foundation

class Video {
    let name: String
    let videoURL: URL
    var downloaded = false
    
    init(name: String, videoURL: URL) {
        self.name = name
        self.videoURL = videoURL
    }
}
