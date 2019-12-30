//
//  APIRetryHandler.swift
//  AuthModule
//
//  Created by Nitin Chadha on 30/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation

class APIRetryHandler: NSObject {
    
    let kAPITimeStamp = "AuthAPITimeStamp"
    
    static let shared = APIRetryHandler()
    var authAPIRetry = 0
    
    @objc func canRetryAuthApi() -> Bool {
        let currentTime = Date().timeIntervalSince1970 as Double
        
        if authAPIRetry == 0 {
            AuthCache.shared.setUserDefaltObject(currentTime, forKey: kAPITimeStamp)
        }
        
        var oldTime  = Date().timeIntervalSince1970 as Double
        if let time = AuthCache.shared.getUserDefaltDouble(forKey: kAPITimeStamp) {
            oldTime = time
        }
        
        if authAPIRetry <= getNumberofRetry() {
            authAPIRetry = authAPIRetry + 1
            if (oldTime < currentTime - getmaximumTimeForAPiCall()) {
                self.refresAuthApiRetry()
            }
            return true
        }
        //refresAuthApiRetry()
        if (oldTime < currentTime - getmaximumTimeForAPiCall()) {
            self.refresAuthApiRetry()
            return true
        }
        return false
        
    }
    
    func refresAuthApiRetry() {
        self.authAPIRetry = 0
        AuthCache.shared.setUserDefaltObject(Date().timeIntervalSince1970, forKey: kAPITimeStamp)
    }
    
    func getNumberofRetry() -> Int {
        return FireBaseHandler.getIntFor(keyPath: .maxApiRetry) ?? 3
    }
    
    func getmaximumTimeForAPiCall() -> Double {
        return FireBaseHandler.getDoubleFor(keyPath: .maxApiRetryInterval) ?? Double()
    }
    
}

