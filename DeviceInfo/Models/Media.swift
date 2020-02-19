//
//  Media.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import MediaPlayer

class Media: ObservableObject {

    @Published var songs = ""
    
    var isAuthorized: Bool {
        MPMediaLibrary.authorizationStatus() == .authorized
    }
    
    init() {
        self.reload()
    }
    
    func requestAuthorization() {
        // App must contain an "NSAppleMusicUsageDescription" key to Info.plist
        MPMediaLibrary.requestAuthorization { (status) in
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

        let query = MPMediaQuery.songs()
        query.addFilterPredicate(MPMediaPropertyPredicate(value: false, forProperty: MPMediaItemPropertyIsCloudItem))
        songs = "\(query.items?.count ?? 0)"
    }
    
}
