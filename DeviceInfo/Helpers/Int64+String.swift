//
//  Int64+String.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

extension Int64 {
    
    var GB: String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = .useGB
        formatter.countStyle = .decimal
        formatter.includesUnit = true
        return formatter.string(fromByteCount: self)
    }
    
}
