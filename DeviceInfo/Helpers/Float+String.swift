//
//  Float+String.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import UIKit

extension Float {
    
    var batteryString: String {
        if self >= 0 {
            return "\(Int(self * 100)) %"
        }
        return "-"
    }
    
}
