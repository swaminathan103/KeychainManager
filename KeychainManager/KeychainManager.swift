//
//  KeychainManager.swift
//  ZoomRx
//
//  Created by Swaminathan on 10/08/20.
//  Copyright © 2020 Swaminathan V. All rights reserved.
//

import Foundation

open class KeychainManager {
    var queryable: KeyChainQueryable
    var keyChainItems:[String:Any]?
    
    init(queryObject:KeyChainQueryable) {
        self.queryable = queryObject
        self.keyChainItems = queryKeychain()
        if let valueData = self.keyChainItems?[kSecValueData as String] as? Data, let valueString = String(data: valueData, encoding: .utf8) {
            self.keyChainItems?[kSecValueData as String] = valueString
        }
    }
    
    /**
     Queries the keychain and returns the items
     */
    open func queryKeychain() -> [String:Any]? {
        var result: AnyObject?
        var query = self.queryable.query
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, $0)
        }
        
        if status == errSecSuccess {
            return result as? [String : Any]
        }
        
        return nil
    }
    
    /**
     Updates the local keyChainItems property if the keychain has been updated successfully
     - returns:
        - True if keyChainItems is successfully updated false otherwise
     - parameters:
        - value: A dictionary to be set in keyChainItems
        - status: The OSStatus of the keychain add or update action
     */
    open func updateLocalValue(value : [String:Any], status:OSStatus) -> Bool {
        if status == errSecSuccess {
            keyChainItems = value
            return true
        } else {
            return false
        }
    }
    
    /**
     Sets the value in the keychain for the account
     - returns:
        - True if keychain is successfully updated false otherwise
     - parameters:
        - value: The kSecValueData value
        - account: The kSecAttrAccount value
     */
    open func setValue(_ value:String?, for account: String) -> Bool {
        
        var returnBool = false
        
        guard let data = value?.data(using: .utf8) else {
            return returnBool
        }
        
        var query = queryable.query
        query[kSecAttrAccount as String] = account
        
        var keyChainItems = query
        
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            status = SecItemUpdate(query as CFDictionary, [kSecValueData as String : data] as CFDictionary)
            keyChainItems[kSecValueData as String] =  value
            returnBool = updateLocalValue(value: keyChainItems, status: status)
            
        case errSecItemNotFound:
            query[kSecValueData as String] = data
            keyChainItems[kSecValueData as String] =  value
            status = SecItemAdd(query as CFDictionary, nil)
            returnBool = updateLocalValue(value: keyChainItems, status: status)
            
        default:
            break
        }
        return returnBool
    }
    
    /**
     Deletes the Items from the keychain if present
     */
    open func resetKeychain() {
        let query = self.queryable.query
        let status:OSStatus = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            return
        }
        keyChainItems?.removeAll()
    }
    
    /**
     Returns value for the given key
     - returns:
        - the value if present else nil
     - parameters:
        - key: The key for which the value needs to be returned
        
     */
    open func value(for key:String) -> Any? {
        if let items = keyChainItems, (items[key] != nil) {
            return items[key]
        }
        return nil
    }
}
