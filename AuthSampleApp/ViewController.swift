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
        if let loginController = AuthRouter.shared.createModule() {
            self.navigationController?.pushViewController(loginController, animated: true)
        }
    }
}

class AuthModuleHelper: AuthModuleUIProtocol {
    
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
    
    func setImage(for imageView: UIImageView, url: URL) {
        
    }
    
}



