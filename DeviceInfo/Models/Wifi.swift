//
//  Wifi.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import CoreLocation
import SystemConfiguration.CaptiveNetwork

class Wifi: ObservableObject {

    @Published var ssid = ""

    var isAuthorized: Bool {
        CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
    
    private var locationManager: CLLocationManager?

    init() {
        reload()
    }

    func requestAuthorization() {
        // App must contain an "NSLocationWhenInUseUsageDescription" key to Info.plist
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        
        DispatchQueue.main.async {
            self.reload()
        }
    }
    
    func reload() {
        guard let interfaceNames = CNCopySupportedInterfaces() as? [String],
            let interfaceName = interfaceNames.first else {
            return
        }

        // App must contain "Access Wifi Information" to capability for using CNCopyCurrentNetworkInfo
        guard let info = CNCopyCurrentNetworkInfo(interfaceName as CFString) as? [String: AnyObject],
            let ssid = info[kCNNetworkInfoKeySSID as String] as? String else {
            return
        }
        
        self.ssid = ssid
    }
    
}
