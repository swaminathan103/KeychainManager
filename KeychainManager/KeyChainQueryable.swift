//
//  KeyChainQueryable.swift
//  KeychainManager
//
//  Created by Swaminathan on 14/08/20.
//  Copyright © 2020 Swaminathan V. All rights reserved.
//

import Foundation

public protocol KeyChainQueryable {
    var query:[String:Any] {get}
}
