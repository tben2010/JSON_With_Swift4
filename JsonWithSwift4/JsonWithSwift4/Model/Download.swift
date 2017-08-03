//
//  Download.swift
//  JsonWithSwift4
//
//  Created by tben on 03.08.17.
//  Copyright © 2017 tben. All rights reserved.
//

import Foundation

class Download {
    var video: Video
    
    init(video: Video) {
        self.video = video
    }
    
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData:Data?
    
    
    var progress:Float = 0
}
