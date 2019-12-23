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
    
    static let bundle: Bundle = Bundle(identifier: "com.goibibo.AuthModule")!
    
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
    
    static func isEmptyString(_ string: Any?) -> Bool {
        guard let string = string as? String, !string.isEmpty else { return true }
        return false
    }
    
    static func isValidTextForMobileField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           
           let textEntered = (textField.text! as NSString).replacingCharacters(in: range, with: string)
           
           if textEntered.count > 10 {
               return false
           }
           
           let blockedCharSet = NSMutableCharacterSet.decimalDigit().inverted
           let invalidRange = textEntered.rangeOfCharacter(from: blockedCharSet)
           
           if invalidRange != nil {
               return false
           }
           
           return true
       }
    
    static func setBusinessProfileSelected(_ isEnabled: Bool) {
        //<NITIN>[[OfflineReviewsFireBase sharedInstance] saveDataBoolforUseronPathWithPath:@"/isBusiness" value:isEnabled completionBlock:^(id ref, id error) {}];
        AuthCache.shared.setUserDefaltBool(isEnabled, forKey: "isBusinessProfile")
    }
    
    static func isValidString(_ string: String?) -> Bool {
        
        guard let string = string, !string.isEmpty else {
            return false
        }

        if string.trimmingCharacters(in: .whitespaces).count <= 0 {
            return false
        }
        
        return true
    }
    
    static func resetCountToLaunch() {
        //<NITIN>[Utils removeMobileKey];
        AuthCache.shared.setUserDefaltInteger(0, forKey: "SocialRegisterMobileCountKey")
    }
    
    static func setNormalAmazonSecureCredential(_ credentials: String) {
        //<NITIN>
    }
    
    static func setChanakyaAmazonSecureCredential(_ credentials: String) {
        //<NITIN>
    }
    
    static func isMobileNetworkConnected() -> Bool {
        return true
    }
}
