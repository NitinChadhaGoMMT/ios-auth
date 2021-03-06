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
    @IBOutlet weak var navigateToAuthModule: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AuthDataProvider.isUserLoggedIn {
            AuthRouter.shared.goToHomePage(vc: self)
        } else if let loginController = AuthRouter.shared.initiateLoginModule() {
            self.navigationController?.pushViewController(loginController, animated: true)
        }
    }
    
    @IBAction func navigateToAuth(_ sender: Any) {
        if AuthDataProvider.isUserLoggedIn {
            AuthRouter.shared.goToHomePage(vc: self)
        } else if let loginController = AuthRouter.shared.createModule() {
            self.navigationController?.pushViewController(loginController, animated: true)
        }
    }
}

class AuthModuleHelper: AuthModuleUIProtocol {
    
    
    func showToastMessage(on view: UIViewController, message: String, duration: CGFloat, position: String) {
        print("MESSAGE : \(message)")
    }
    
    
    func setImage(for imageView: UIImageView, url: URL?, placeholder: UIImage?, completionBlock: (() -> Void)?) {
        guard let url = url else { return }
        
        imageView.image = placeholder
        imageView.sd_setImage(with: url) { (image, error, type, url) in
            imageView.image = image
            if let completionBlock = completionBlock {
                completionBlock()
            }
        }
    }
    
    
    func removeBranchReferCode() {
        
    }
    
    func showIBSVAlert(withTitle title: String?, msg: String?, confirmTitle: String?, cancelTitle: String?, onCancel: @escaping () -> Void, onConfirm: @escaping () -> Void) {
        
    }
    
    func authLoginCompletion(isUserLoggedIn: Bool, error: Error?) {
        
    }
    
    func setImage(for imageView: UIImageView, url: URL?, placeholder: UIImage?) {
        
        guard let url = url else { return }
        
        imageView.image = placeholder
        imageView.sd_setImage(with: url) { (image, error, type, url) in
            imageView.image = image
        }
    }
    
    
    func showToastMessage(on view: UIViewController, message: String) {
        print("message : \(message)")
        showAlert(on: view, message: message)
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



