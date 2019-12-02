//
//  AuthUtils.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 27/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

struct AuthNetworkUtils {
    
    static func getServer_C() -> String {
        return AuthDepedencyInjector.networkDelegate?.getServer_C() ?? AuthNetworkConstants.server_C
    }
    
    static func syncMD() -> String {
        return "78IUdfh@m^xlpwq)$a0#";
    }
    
    static func getAuthKey() -> String {
        return AuthDepedencyInjector.networkDelegate?.getAuthKey() ?? AuthNetworkConstants.authKey
    }
    
    static func getUUID() -> String {
        //<NITIN>
        return AuthDepedencyInjector.networkDelegate?.getUUID() ?? UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
}

struct AuthUtils {
    
    static func isValidPhoneNumber(_ numberText: String?) -> Bool {
        
        guard let phoneNumber = numberText else {
            return false
        }
        
        let phonrNumberRegex: String = "^[56789]\\d{9}$"
        let testPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", phonrNumberRegex)
        return testPredicate.evaluate(with: phoneNumber)
    }
    
    static func showAlert(on view:UIViewController, message: String) {
        AuthDepedencyInjector.uiDelegate?.showAlert(on: view, message: message)
    }
    
    static func isEmptyString(_ string: String?) -> Bool {
        return string?.isEmpty ?? true
    }
}
