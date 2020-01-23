//
//  AuthAlert.swift
//  AuthModule
//
//  Created by Nitin Chadha on 29/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

struct AuthAlert {
    
    static func show(withTitle: String = .goibibo, message: String) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            let alertController = UIAlertController(title: .goibibo, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(action)
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showToastMessage(on view: UIViewController, message: String, duration: CGFloat, position: String) {
        AuthDepedencyInjector.uiDelegate?.showToastMessage(on: view, message: message, duration: duration, position: position)
    }
    
    static func showToastMessage(on view: UIViewController, message: String) {
        AuthDepedencyInjector.uiDelegate?.showToastMessage(on: view, message: message)
    }
    
    static func noInternetAlert() {
        showIBSVAlert(withTitle: .goibibo, msg: "You appear to be offline. Please check your internet connection.", confirmTitle: "Ok", cancelTitle: nil, onCancel: { }) { }
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
        let alertController = UIAlertController(title: .goibibo, message: "Please enter a valid name", preferredStyle: .alert)
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
    
    static func showIBSVAlert(withTitle title: String, msg: String, confirmTitle: String?, cancelTitle: String?, onCancel: @escaping  () -> Void, onConfirm: @escaping  () -> Void) {
        AuthDepedencyInjector.uiDelegate?.showIBSVAlert(withTitle: title, msg: msg, confirmTitle: confirmTitle, cancelTitle: cancelTitle, onCancel: onCancel, onConfirm: onConfirm)
    }
}
