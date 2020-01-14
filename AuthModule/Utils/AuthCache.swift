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
    
    private override init() {
        UserDefaults.standard.setSecret("Goibibo")
        UserDefaults.standard.setData()
        let goKey = "pci_go_GoAppInstallDate"
        var version = UserDefaults.standard.secretObject(forKey: goKey)
        if AuthUtils.isEmptyString(version) {
            UserDefaults.standard.setDataNew()
            version = UserDefaults.standard.secretObject(forKey: goKey)
            if AuthUtils.isEmptyString(version) {
                UserDefaults.standard.removeDataNew()
            }
        }
    }
    
    func goKeyString(_ key: String) -> String {
        if key.contains("pci_go_") {
            return key
        } else {
            return "pci_go_" + key
        }
    }
    
    func getUserDefaltObject(forKey key: String) -> Any? {
        let goKey = self.goKeyString(key)
        return UserDefaults.standard.object(forKey: goKey)
    }
    
    func getUserDefaltBool(forKey key: String) -> Bool? {
        let goKey = self.goKeyString(key)
        return UserDefaults.standard.bool(forKey: goKey)
    }
    
    func setUserDefaltObject(_ value: Any?, forKey key: String) {
        let goKey = self.goKeyString(key)
        UserDefaults.standard.setValue(value, forKeyPath: goKey)
    }
    
    func setUserDefaltDouble(_ value: Double, forKey key: String) {
        let goKey = self.goKeyString(key)
        UserDefaults.standard.setValue(value, forKeyPath: goKey)
    }
    
    func getUserDefaltDouble(forKey key: String) -> Double? {
        let goKey = self.goKeyString(key)
        return UserDefaults.standard.double(forKey: goKey)
    }
    
    func setUserDefaltInteger(_ value: Int?, forKey key: String) {
        let goKey = self.goKeyString(key)
        UserDefaults.standard.set(value, forKey: goKey)
    }
    
    func setUserDefaltBool(_ value: Bool, forKey key: String) {
        let goKey = self.goKeyString(key)
        UserDefaults.standard.set(value, forKey: goKey)
    }
    
    func removeDefaultObject(forKey key: String) {
        let goKey = self.goKeyString(key)
        UserDefaults.standard.removeObject(forKey: goKey)
        UserDefaults.standard.synchronize()
    }
}
