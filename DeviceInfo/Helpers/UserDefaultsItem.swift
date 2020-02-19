//
//  UserDefaultsItem.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultsItem {

    private let key: String

    init(key: String) {
        self.key = key
    }
    
    var wrappedValue: String? {
        get {
            return UserDefaults.standard.string(forKey: key) ?? nil
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }

}
