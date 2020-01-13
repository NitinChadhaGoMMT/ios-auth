//
//  FireBaseHandler.swift
//  AuthModule
//
//  Created by Nitin Chadha on 09/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import Foundation

class FireBaseHandler {
    
    static let FirebaseDelegate = AuthDepedencyInjector.firebaseHandlerDelegate
    
    static func getDoubleFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> Double? {
        return FirebaseDelegate?.getDoubleFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func getIntFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> Int? {
        return FirebaseDelegate?.getIntFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func getStringFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> String? {
        return FirebaseDelegate?.getStringFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func getBoolFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> Bool? {
        
        if keyPath == .KeychainLogInEnabled {
            return true
        }
        
        return FirebaseDelegate?.getBoolFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func getDictionaryFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> Dictionary<AnyHashable, Any> {
        return [:]
    }
    
    static func getArrayFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> [Any] {
        return []
    }
    
    static func getRemoteFunctionBoolValue(forKey key: String) -> Bool {
        return AuthDepedencyInjector.firebaseRemoteHandlerDelegate?.getRemoteFunctionBoolValueWithForkey(forKey: key) ?? true
    }
}
