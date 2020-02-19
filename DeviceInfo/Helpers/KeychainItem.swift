//
//  KeychainItem.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

@propertyWrapper
final public class KeychainItem {

    private let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public var wrappedValue: String? {
        get {
            read()
        }
        set {
            if let value = newValue {
                if read() == nil {
                    add(value)
                } else {
                    update(value)
                }
            } else {
                delete()
            }
        }
    }
    
    private func add(_ secret: String) {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key as AnyObject,
            kSecValueData as String: secret.data(using: .utf8)! as AnyObject
        ]

        SecItemAdd(query as CFDictionary, nil)
    }

    private func read() -> String? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true as AnyObject
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status != errSecItemNotFound,
            let data = result as? Data,
            let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        return string
    }
    
    private func update(_ secret: String) {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key as AnyObject
        ]

        let attributesToUpdate = [
            kSecValueData as String: secret.data(using: .utf8)! as AnyObject
        ]

        SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
    }

    private func delete() {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key as AnyObject
        ]

        SecItemDelete(query as CFDictionary)
    }

}
