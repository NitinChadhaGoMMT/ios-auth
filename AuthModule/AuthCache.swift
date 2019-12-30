//
//  AuthCache.swift
//  AuthModule
//
//  Created by Nitin Chadha on 10/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import CoreData

class AuthCache: NSObject {

    static let shared = AuthCache()
    
    var facebookToken: String!
    
    func getUserDefaltObject(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    func getUserDefaltBool(forKey key: String) -> Bool? {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    func setUserDefaltObject(_ value: Any?, forKey key: String) {
        UserDefaults.standard.setValue(value, forKeyPath: key)
    }
    
    func setUserDefaltDouble(_ value: Double, forKey key: String) {
        UserDefaults.standard.setValue(value, forKeyPath: key)
    }
    
    func getUserDefaltDouble(forKey key: String) -> Double? {
        return UserDefaults.standard.double(forKey: key)
    }
    
    func setUserDefaltInteger(_ value: Int?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func setUserDefaltBool(_ value: Bool, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func removeDefaultObject(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
