//
//  UIDevice+Extension.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import UIKit
import AdSupport
import LocalAuthentication
import CoreMotion

extension UIDevice {
    
    // MARK: - Identifiers
    
    var identifierForAdvertisers: UUID? {
        let manager = ASIdentifierManager.shared()
        if manager.isAdvertisingTrackingEnabled {
            return manager.advertisingIdentifier
        }
        
        // User limited Ad Tracking
        return nil
    }
    
    // MARK: - Model

    var modelID: String? {
        var systemInfo = utsname()
        uname(&systemInfo)

        return withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(validatingUTF8: $0)
            }
        }
    }
    
    // MARK: - Storage
    
    var storageCapacity: String? {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
            let capacity = systemAttributes[FileAttributeKey.systemSize] as? Int64 else {
            return nil
        }
        return "\(capacity.GB)"
    }

    var storageAvailable: String? {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
            let available = systemAttributes[FileAttributeKey.systemFreeSize] as? Int64 else {
            return nil
        }
        // The value obtained seems wrong...
        return "\(available.GB)"
    }
    
    // MARK: - Screen
    
    var screenBrightness: CGFloat? {
        UIScreen.main.brightness
    }
    
    var screenResolution: CGSize {
        let screen = UIScreen.main
        let size = screen.bounds.size
        let scale = screen.scale
        
        return CGSize(width: size.width * scale,
                      height: size.height * scale)
    }
    
    // MARK: - Authentication
    
    var ownerAuthentication: String {
        let context = LAContext()

        var error: NSError?
        let supportBiometry = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        
        if supportBiometry {
            switch context.biometryType {
            case .touchID:
                return "Touch ID"
            case .faceID:
                return "Face ID"
            case .none:
                return "None"
            @unknown default:
                return "Unknown"
            }
        }

        let supportPasscord = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)

        if supportPasscord {
            return "Passcode"
        }

        return "None"
    }

}
