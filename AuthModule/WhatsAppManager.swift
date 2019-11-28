//
//  WhatsAppHelper.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit


class SharedCache {
    
    static var shared = SharedCache()
    
    func getUserDefaltObject(forKey: String) -> Dictionary<AnyHashable, Any>{
        return [:]
    }
    
}

class FireBaseHandler {
    static func getStringFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> String {
        return ""
    }
    
    static func getBoolFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> Bool {
        return false
    }
    
    static func getDictionaryFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> Dictionary<AnyHashable, Any> {
        return [:]
    }
    
    static func getArrayFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> [Any] {
        return []
    }
}

class WhatsAppManager {
    
    static let shared = WhatsAppManager()
    //<NITIN>  CHECK KEYPATH
    func canOpenWhatsApp() -> Bool {
        let phone = FireBaseHandler.getStringFor(keyPath: .whatsapp_login_msg, dbPath: .goCoreDatabase)
        let abid = FireBaseHandler.getStringFor(keyPath: .whatsapp_login_msg, dbPath: .goCoreDatabase)
        let urlWhats = "whatsapp://send?phone=\(phone)&abid=\(abid)&text="
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    return true
                }
            }
        }
        return false
    }
    
    func isWhatsAppLoginEnabled() -> Bool {
        
        guard canOpenWhatsApp() else {
            return false
        }
        
        let whatsAppEnabled = FireBaseHandler.getBoolFor(keyPath: .whatsapp_login_msg, dbPath: .goCoreDatabase)
        if(whatsAppEnabled == true) {
            //let status = FirebaseRemoteHelper.sharedInstance.getRemoteFunctionBoolValue(forkey: "remote_whatsapp_enabled")
            //return status
            return false
        }
        
        return false
    }
}
