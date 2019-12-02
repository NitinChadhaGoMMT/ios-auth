//
//  AuthAlert.swift
//  AuthModule
//
//  Created by Nitin Chadha on 29/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

struct AuthAlert {

    static func showReferralCodeAlert(view: UIViewController, success: @escaping (String?) -> Void, cancel: @escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Referral Code", message: "Please input your code:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            guard let field = alertController.textFields?.first, field.text?.isEmpty == false else {
                AuthUtils.showAlert(on: view, message: "Referral code is empty")
                return
            }
            success(field.text)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            cancel()
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Referral Code"
            textField.keyboardType = .asciiCapable;
            textField.autocapitalizationType = .allCharacters
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    static func showErrorAlert(view: UIViewController, title: String? = "Goibibo", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        view.show(alertController, sender: nil)
    }
    
    
}
