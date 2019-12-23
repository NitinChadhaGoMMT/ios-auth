//
//  FirebaseHandlerProtocol.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 26/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

@objc public protocol FirebaseHandlerProtocol {
    
    @objc static func getStringFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> String
    
    @objc static func getIntFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> Int
    
    @objc static func getBoolFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> Bool
    
    @objc static func getDictionaryFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> Dictionary<String, Any>
    
    @objc static func getArrayFor(keyPath: FirebaseConfigKey, dbPath:FirebaseDatabaseKey) -> Array<Any>
    
    @objc static func addObserverForString(with completionHandler: @escaping(Dictionary<String, Any>?) -> Void)
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

@objc public protocol FirebaseRemoteHelperProtocol {
    
    @objc static func getRFStringValue(forkey key:String) -> String
}


public extension FirebaseRemoteHelperProtocol {
    
    static func getRFStringValue(forkey key:String) -> String {
        return getRFStringValue(forkey: key)
    }
}

public protocol CommonAnalytisProtocol {
    
    static func logCategory(event: String, dictionary: Dictionary<String, Any>?)
    
    
    
    
}

