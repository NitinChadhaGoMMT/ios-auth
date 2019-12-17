//
//  AuthCache.swift
//  AuthModule
//
//  Created by Nitin Chadha on 10/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class AuthCache: NSObject {

    static let shared = AuthCache()
    
    var dictionary = [String: Any]()
    
    var facebookToken: String!
    
    func getUserDefaltObject(forKey key: String) -> Any? {
        return dictionary[key]
    }
    
    func setUserDefaltObject(_ value: Any?, forKey key: String) {
        dictionary[key] = value
    }
}
