//
//  ViewController.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import AuthModule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let loginController = AuthRouter.shared.createModule() {
            self.navigationController?.pushViewController(loginController, animated: true)
        }
    }
}

class AuthModuleHelper: AuthModuleUIProtocol {
    
    static let shared = AuthModuleHelper()
    
    func showAlert(on view: UIViewController, message: String) {
        let alert = UIAlertController(title: "Auth Module", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator(on _view: UIView) {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = _view.center
        _view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func hideActivityIndicator(from view: UIView) {
        
    }
    
    
}



