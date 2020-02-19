//
//  LanguageAndRegion.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct LanguageAndRegion {
    
    static var language: String? {
        guard let code = Locale.current.languageCode,
            let language = Locale.current.localizedString(forLanguageCode: code) else {
            return nil
        }
        return language
    }

    static var preferredLanguages: [String] {
        Locale.preferredLanguages.map({
            Locale.current.localizedString(forLanguageCode: $0) ?? $0
        })
    }

    static var region: String? {
        guard let code = Locale.current.regionCode,
            let region = Locale.current.localizedString(forRegionCode: code) else {
            return nil
        }
        return region
    }
    
    static var calendar: String? {
        guard let calendar = Locale.current.localizedString(for: Locale.current.calendar.identifier) else {
            return nil
        }
        return calendar
    }
    
    static var tempertureUnit: String {
        let tempature = Measurement(value: 36.0, unit: UnitTemperature.celsius)
        let formatter = MeasurementFormatter()
        let localizedTempature = formatter.string(from: tempature)
        if localizedTempature.contains("C") {
            return "°C"
        } else {
            return "°F"
        }
    }
    
}
