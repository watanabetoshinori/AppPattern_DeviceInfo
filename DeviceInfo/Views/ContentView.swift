//
//  ContentView.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI
import CoreMotion
import CoreLocation

struct ContentView: View {
    
    @ObservedObject var media = Media()

    @ObservedObject var photoAndVideo = PhotoAndVideo()

    @ObservedObject var wifi = Wifi()
    
    var customIdentifier = CustomIdentifier()
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Identifiers")) {
                    Cell(title: "UserDefaults", detail: .constant(customIdentifier.inUserDefaults ?? "-"))
                    Cell(title: "Keychain", detail: .constant(customIdentifier.inKeychain ?? "-"))
                    Cell(title: "IDFV", detail: .constant(UIDevice.current.identifierForVendor?.uuidString ?? "-"))
                    Cell(title: "IDFA", detail: .constant(UIDevice.current.identifierForAdvertisers?.uuidString ?? "-"))
                }
                Section(header: Text("App")) {
                    Cell(title: "Name", detail: .constant(AppInfo.name ?? "-"))
                    Cell(title: "Version", detail: .constant(AppInfo.version ?? "-"))
                    Cell(title: "Build", detail: .constant(AppInfo.build ?? "-"))
                }
                Section(header: Text("Device")) {
                    Cell(title: "Name", detail: .constant(UIDevice.current.name))
                    Cell(title: "Software Name", detail: .constant(UIDevice.current.systemName))
                    Cell(title: "Software Version", detail: .constant(UIDevice.current.systemVersion))
                    Cell(title: "Model Name", detail: .constant(UIDevice.current.localizedModel))
                    Cell(title: "Model ID", detail: .constant(UIDevice.current.modelID ?? "-"))
                    Cell(title: "Capacity", detail: .constant(UIDevice.current.storageCapacity ?? "-"))
                    Cell(title: "Authentication", detail: .constant(UIDevice.current.ownerAuthentication))
                    Cell(title: "Battery", detail: .constant(UIDevice.current.batteryLevel.batteryString))
                }
                Section(header: Text("Display & Brightness")) {
                    Cell(title: "Screen Resolution", detail: .constant(UIDevice.current.screenResolution.resolutionString))
                    Cell(title: "Screen Brightness", detail: .constant("\(UIDevice.current.screenBrightness ?? 0)"))
                }
                Section(header: Text("Sensors")) {
                    Cell(title: "Accelerometer", detail: .constant(CMMotionManager().isAccelerometerAvailable ? "On" : "Off"))
                    Cell(title: "Gyro", detail: .constant(CMMotionManager().isGyroAvailable ? "On" : "Off"))
                    Cell(title: "Device Motion", detail: .constant(CMMotionManager().isDeviceMotionAvailable ? "On" : "Off"))
                    Cell(title: "Magneto Meter", detail: .constant(CMMotionManager().isMagnetometerAvailable ? "On" : "Off"))
                    Cell(title: "Step Counting", detail: .constant(CMPedometer.isStepCountingAvailable() ? "On" : "Off"))
                    Cell(title: "Heading", detail: .constant(CLLocationManager.headingAvailable() ? "On" : "Off"))
                }
                Section(header: Text("Language & Region")) {
                    Cell(title: "Language", detail: .constant(LanguageAndRegion.language ?? "-"))
                    Cell(title: "Preferred Language", detail: .constant(LanguageAndRegion.preferredLanguages.joined(separator: ", ")))
                    Cell(title: "Region", detail: .constant(LanguageAndRegion.region ?? "-"))
                    Cell(title: "Calendar", detail: .constant(LanguageAndRegion.calendar ?? "-"))
                    Cell(title: "Temperature Unit", detail: .constant(LanguageAndRegion.tempertureUnit))
                }
                Section(header: Text("Cellular")) {
                    Cell(title: "Cerrier", detail: .constant(Cellular.carrier ?? "-"))
                    Cell(title: "Mobile Country Code", detail: .constant(Cellular.mobileCountryCode ?? "-"))
                    Cell(title: "Mobile Network Code", detail: .constant(Cellular.mobileNetworkCode ?? "-"))
                }
                Section(header: Text("Media"), footer: Text("Grant media library access to show this section.")) {
                    Cell(title: "Songs", detail: $media.songs)
                    if media.isAuthorized == false {
                        Button(action: media.requestAuthorization) {
                            Text("Request Media Library Authorization")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                Section(header: Text("Photo and Video"), footer: Text("Grant asset library access to show this section.")) {
                    Cell(title: "Photos", detail: $photoAndVideo.photos)
                    Cell(title: "Videos", detail: $photoAndVideo.videos)
                    if photoAndVideo.isAuthorized == false {
                        Button(action: photoAndVideo.requestAuthorization) {
                            Text("Request Asset Livrary Authorization")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                Section(header: Text("Wifi"), footer: Text("Grant location access to show this section.")) {
                    Cell(title: "Wifi", detail: $wifi.ssid)
                    if wifi.isAuthorized == false {
                        Button(action: wifi.requestAuthorization) {
                            Text("Request LocationAuthorization")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Information", displayMode: .inline)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
