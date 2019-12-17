//
//  KeychainLoginHandler.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import CommonCrypto

class KeychainLoginHandler {
    
    static let shared = KeychainLoginHandler()

    func getDeviceId() -> String? {
        
        return KeychainWrapper.standard.string(forKey: "device_id")
    }
    
    func setDeviceId(){
        KeychainWrapper.standard.set("Utils.deviceUUID()", forKey: "device_id")
    }
}
