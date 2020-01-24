//
//  FirebaseHandlerProtocol.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 26/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import CommonFramework

public protocol FirebaseHandlerProtocol {
    
    static func getStringFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> String
    
    static func getIntFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> Int
    
    static func getDoubleFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> Double
    
    static func getBoolFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> Bool
    
    static func getDictionaryFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> Dictionary<String, Any>
    
    static func getArrayFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> Array<Any>
    
    static func addObserverForString(with completionHandler: @escaping(Dictionary<String, Any>?) -> Void)
}

public extension FirebaseHandlerProtocol {
    
    static func getStringFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey = .goConfigDatabase) -> String {
        return getStringFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func getIntFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey = .goConfigDatabase) -> Int {
        return getIntFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func getBoolFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey = .goConfigDatabase) -> Bool {
        return getBoolFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func getDictionaryFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey = .goConfigDatabase) -> Dictionary<String, Any> {
        return getDictionaryFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func getArrayFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey = .goConfigDatabase) -> Array<Any> {
        return getArrayFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func addObserverForString(with completionHandler: @escaping(Dictionary<String, Any>?) -> Void) {
        return addObserverForString(with: completionHandler)
    }
}

public protocol FirebaseRemoteHelperProtocol {
    
    static func getRFStringValue(forkey key:String) -> String
    
    static func getRemoteFunctionBoolValueWithForkey(forKey key:String) -> Bool
}


public extension FirebaseRemoteHelperProtocol {
    
    static func getRFStringValue(forkey key:String) -> String {
        return getRFStringValue(forkey: key)
    }
}

public protocol CommonAnalytisProtocol {
    
    static func logCategory(event: String, dictionary: Dictionary<String, Any>?)
    
    static func pushEvent(withName name: String, withAttributes attributes: [AnyHashable: Any]?)
    
}

