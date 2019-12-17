//
//  UserDataManager.swift
//  AuthModule
//
//  Created by Nitin Chadha on 29/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class UserDataManager {

    static var shared = UserDataManager()
    
    private init() { }
    
    var isWAChecked: Bool = false
    
    var isLoggedIn = false
    
    func clearCookiesAndCache() {
        if let storedCookies = HTTPCookieStorage.shared.cookies {
            for cookie in storedCookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        URLCache.shared.removeAllCachedResponses()
    }
    
    func updateLoggedInUser(to dictionary: Dictionary<String, Any>) {
        //<NITIN>
    }
    
    func accessTokenUpdated() {
        //<NITIN>
    }
    
    static func updateLoggedInUserGoCash() {
        
    }
    
}
