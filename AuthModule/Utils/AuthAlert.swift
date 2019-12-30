//
//  AuthAlert.swift
//  AuthModule
//
//  Created by Nitin Chadha on 29/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

struct ActivityIndicator {
    static func show(on view: UIView?, withMessage message: String? = nil) {
        
        guard let view = view else { return }
        
        AuthDepedencyInjector.uiDelegate?.showActivityIndicator(on: view)
    }
    
    static func hide(on view: UIView?) {
        
        guard let view = view else { return }
        
        AuthDepedencyInjector.uiDelegate?.hideActivityIndicator(from: view)
    }
}

struct AuthAlert {
    
    static func show(withTitle: String = "Goibibo", message: String) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            let alertController = UIAlertController(title: "Goibibo", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(action)
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showToastMessage(on view: UIViewController, message: String) {
        AuthDepedencyInjector.uiDelegate?.showToastMessage(on: view, message: message)
    }
    
    static func showAppGenericAlert(on view: UIViewController, message: String) {
        AuthDepedencyInjector.uiDelegate?.showAlert(on: view, message: message)
    }

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
    
    static func showErrorAlert(view: UIViewController, title: String? = "Error!", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        view.present(alertController, animated: true, completion: nil)
    }
    
    static func showEmptyMobileErrorAlert(view: UIViewController) {
        let alertController = UIAlertController(title: "Mobile Number missing", message: "Please enter mobile number.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        view.present(alertController, animated: true, completion: nil)
    }
    
    static func showEmptyPasswordErrorAlert(view: UIViewController) {
        let alertController = UIAlertController(title: "Password missing", message: "Please enter password.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        view.present(alertController, animated: true, completion: nil)
    }
    
    static func showInvalidMobileAlert(view: UIViewController) {
        let alertController = UIAlertController(title: "Wrong mobile no!", message: "Please enter valid mobile number.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        view.present(alertController, animated: true, completion: nil)
    }
    
    static func showInvalidNameErrorAlert(view: UIViewController) {
        let alertController = UIAlertController(title: "Goibibo", message: "Please enter a valid name", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        view.present(alertController, animated: true, completion: nil)
    }
    
    static func showSucessAlert(withMessage message: String, view: UIViewController, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        view.present(alertController, animated: true, completion: completion)
    }
    
    static func showSkipLoginAlert(withMessage message: String, onView view: UIViewController, continueAction: ((UIAlertAction) -> Void)?,cancelAction: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "Are you sure?", message: message, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "CONTINUE", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "SKIP", style: .default, handler: cancelAction)
        alertController.addAction(continueAction)
        alertController.addAction(cancelAction)
        view.present(alertController, animated: true, completion: nil)
    }
}
