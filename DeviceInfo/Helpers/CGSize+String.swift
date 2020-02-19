//
//  CGSize+String.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {
    
    var resolutionString: String {
        "\(Int(height))-by-\(Int(width))-pixel"
    }
    
}
