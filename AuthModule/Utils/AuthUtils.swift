//
//  AuthUtils.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 27/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

struct AuthUtils {
    
    static func isValidPhoneNumber(_ numberText: String?) -> Bool {
        
        guard let phoneNumber = numberText else {
            return false
        }
        
        let phonrNumberRegex: String = "^[56789]\\d{9}$"
        let testPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", phonrNumberRegex)
        return testPredicate.evaluate(with: phoneNumber)
    }
    
    static func showAlert(_ message: String) {
        
    }
}
