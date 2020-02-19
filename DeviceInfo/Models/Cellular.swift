//
//  Cellular.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import CoreTelephony

struct Cellular {
    
    static var carrier: String? {
        guard let providers = CTTelephonyNetworkInfo().serviceSubscriberCellularProviders,
            let carrierName = providers.first?.value.carrierName else {
            return nil
        }
        
        return carrierName
    }
    
    static var mobileCountryCode: String? {
        guard let providers = CTTelephonyNetworkInfo().serviceSubscriberCellularProviders,
            let mobileCountryCode = providers.first?.value.mobileCountryCode else {
            return nil
        }
        
        return mobileCountryCode
    }

    static var mobileNetworkCode: String? {
        guard let providers = CTTelephonyNetworkInfo().serviceSubscriberCellularProviders,
            let mobileNetworkCode = providers.first?.value.mobileNetworkCode else {
            return nil
        }
        
        return mobileNetworkCode
    }

}
