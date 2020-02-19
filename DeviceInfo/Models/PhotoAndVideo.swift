//
//  PhotoAndVideo.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import Photos

class PhotoAndVideo: ObservableObject {

    @Published var photos = ""

    @Published var videos = ""

    var isAuthorized: Bool {
        PHPhotoLibrary.authorizationStatus() == .authorized
    }

    init() {
        reload()
    }

    func requestAuthorization() {
        // App must contain an "NSPhotoLibraryUsageDescription" key to Info.plist
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.async {
                    self.reload()
                }
            }
        }
    }
    
    func reload() {
        guard isAuthorized else {
            return
        }

        let photoAssets = PHAsset.fetchAssets(with: .image, options: nil)
        photos = "\(photoAssets.count)"

        let videoAssets = PHAsset.fetchAssets(with: .video, options: nil)
        videos = "\(videoAssets.count)"
    }
    
}
