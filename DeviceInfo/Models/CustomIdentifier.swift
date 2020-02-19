//
//  CustomIdentifier.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import UIKit
import AdSupport

class CustomIdentifier {

    @UserDefaultsItem(key: "uuid")
    var inUserDefaults: String?

    @KeychainItem(key: "uuid")
    var inKeychain: String?
    
    init() {
        generateIdentifierIfNotExists()
    }
    
    func generateIdentifierIfNotExists() {
        if inUserDefaults == nil {
            inUserDefaults = UUID().uuidString
        }
        
        if inKeychain == nil {
            inKeychain = UUID().uuidString
        }
    }
    
    func reset() {
        inUserDefaults = nil
        inKeychain = nil
        
        generateIdentifierIfNotExists()
    }
    
}
