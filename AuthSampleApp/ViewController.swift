//
//  ViewController.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import AuthModule
import SDWebImage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if AuthDataProvider.isUserLoggedIn {
            AuthModuleHelper.shared.showAlert(on: self, message: "UserLoggedInSuccessfully")
            AuthDataProvider.logoutUser()
        } else if let loginController = AuthRouter.shared.createModule() {
            self.navigationController?.pushViewController(loginController, animated: true)
        }
    }
}

class AuthModuleHelper: AuthModuleUIProtocol {
    
    func showAlertActionPrompt(withTitle title: String?, msg: String?, confirmTitle: String?, cancelTitle: String?, onCancel: @escaping () -> Void, onConfirm: @escaping () -> Void) -> UIAlertController? {
        return UIAlertController.init()
    }
    
    
    func setImage(for imageView: UIImageView, url: URL, placeholder: UIImage?) {
        
    }
    
    
    func showToastMessage(on view: UIViewController, message: String) {
        
    }
    
    func showActivityIndicator(on view: UIView, withMessage message: String) {
        
    }
    
    static let shared = AuthModuleHelper()
    
    var activityView: UIActivityIndicatorView?
    
    func showAlert(on view: UIViewController, message: String) {
        let alert = UIAlertController(title: "Auth Module", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator(on _view: UIView) {
        activityView = UIActivityIndicatorView(style: .gray)
        activityView?.center = _view.center
        _view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(from view: UIView) {
        if activityView != nil {
            activityView?.removeFromSuperview()
        }
    }
    
}



