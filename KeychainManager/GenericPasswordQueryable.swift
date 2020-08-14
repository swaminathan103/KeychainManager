//
//  GenericPasswordQueryable.swift
//  ZoomRx
//
//  Created by Swaminathan on 10/08/20.
//  Copyright © 2020 Swaminathan V. All rights reserved.
//

import Foundation

public struct GenericPasswordQueryable: KeyChainQueryable {
    var service:String
    var accessGroup:String?
    
    init(service: String, accessGroup:String?) {
        self.service = service
        self.accessGroup = accessGroup
    }
    
    public var query: [String : Any] {
        var newQuery = [String:Any]()
        newQuery[kSecClass as String] = kSecClassGenericPassword
        newQuery[kSecAttrService as String] = self.service
        
        #if !targetEnvironment(simulator)
        newQuery[kSecAttrAccessGroup as String] = self.accessGroup
        #endif
        
        return newQuery
    }
}
