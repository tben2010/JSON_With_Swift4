//
//  MovieVC+URLSessionDelegate.swift
//  JsonWithSwift4
//
//  Created by tben on 03.08.17.
//  Copyright © 2017 tben. All rights reserved.
//

import Foundation

extension MovieVC: URLSessionDownloadDelegate   {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //print("Did Finish Downloading to \(location)")
        
        //1 Orginal URL wird geholt
        guard let sourceURL = downloadTask.originalRequest?.url else {return}
        let download = downloadService.activeDownloads[sourceURL]
        downloadService.activeDownloads[sourceURL] = nil
        
        //2 Neuer Zielpfad wird festgelegt
        let destinationURL = localFilePath(for: sourceURL)
        //print("Ziel Verzeichnis \(destinationURL)")
        
        //3 Sollte in dem Verzeichnis ein File liegen wird dieser entfernt und dann wird er dort hinkopiert
        let fileManager  = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            download?.video.downloaded = true
        } catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
    }
    
    // MARK: Progress fortschritt
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        print("didWriteData")
        
        guard let url = downloadTask.originalRequest?.url,
            let download = downloadService.activeDownloads[url] else {return}
        
        download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
        
        DispatchQueue.main.async {
            self.updateDisplay(progress: download.progress, totalSize: totalSize)
        }
    }
}
