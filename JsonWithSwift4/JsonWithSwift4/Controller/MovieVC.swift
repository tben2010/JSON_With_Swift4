//
//  MovieVC.swift
//  JsonWithSwift4
//
//  Created by tben on 01.08.17.
//  Copyright © 2017 tben. All rights reserved.
//

import AVFoundation
import UIKit
import AVKit

class MovieVC: UIViewController {
    
    @IBOutlet weak var progressViewOutlet: UIProgressView!
    var movieLabel: String!
    var movieURL: String!
    var newVideo: Video?
    
    let downloadService = DownloadService()
    
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func localFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    
    
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(movieLabel)
        
        downloadService.downloadsSession = downloadsSession
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func downloadTapped(_ sender: Any) {
        guard let videoURL = URL(string: movieURL) else {
            print("videoURL not working")
            return
        }
        
        newVideo = Video(name: movieLabel, videoURL: videoURL)
        downloadService.startDownload(newVideo!)
    }
    
    @IBAction func playVideoTapped(_ sender: Any) {
//        if newVideo!.downloaded {
//            playDownload(newVideo!)
//        }
        playDownload(newVideo!)
        
    }
    func playDownload(_ video: Video){
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        let url = localFilePath(for: video.videoURL)
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
    }
    
    func updateDisplay(progress:Float, totalSize:String) {
        progressViewOutlet.progress = progress
        //progressLabel.text = String(format: "%.1f%% of %@",progress * 100,totalSize)
    }
    
}
