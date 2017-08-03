

import Foundation

// Downloads Video's, and stores in local file.
// Allows cancel, pause, resume download.
class DownloadService {
  
  var activeDownloads: [URL: Download] = [:]

    //TODO: create downloadSession
  // SearchViewController creates downloadsSession
  var downloadsSession: URLSession!

  // MARK: - Download methods called by TrackCell delegate methods

  func startDownload(_ video: Video) {
    // TODO
    let download = Download(video: video)
    
    download.task = downloadsSession.downloadTask(with: video.videoURL)
    
    download.task?.resume()
    
    download.isDownloading = true
    
    activeDownloads[download.video.videoURL] = download
    
  }
  // TODO: previewURL is http://a902.phobos.apple.com/...
  // why doesn't ATS prevent this download?

  func pauseDownload(_ video: Video) {
    guard let download = activeDownloads[video.videoURL] else {return}
    if download.isDownloading {
      download.task?.cancel(byProducingResumeData: { (data) in
        download.resumeData = data
      })
      download.isDownloading = false
    }
  }

  func cancelDownload(_ video: Video) {
    if let download = activeDownloads[video.videoURL] {
      download.task?.cancel()
      activeDownloads[video.videoURL] = nil
    }
  }

  func resumeDownload(_ video: Video) {
    guard let download = activeDownloads[video.videoURL] else {return}
    if let resumeData = download.resumeData {
      download.task = downloadsSession.downloadTask(withResumeData: resumeData)
    } else {
      download.task = downloadsSession.downloadTask(with: download.video.videoURL)
    }
    download.task!.resume()
    download.isDownloading = true
  }

}
