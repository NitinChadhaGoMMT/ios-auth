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
    @IBOutlet weak var navigateToAuthModule: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AuthDataProvider.isUserLoggedIn {
            AuthRouter.goToHomePage(vc: self)
        } else  {
            AuthRouter.shared.invokeLoginFlow(onNavigationStack: self.navigationController) { (isLoggedIn, error) in
                print("From Main - User Logged In Successfully")
                AuthRouter.goToHomePage(vc: self)
            }
        }
    }
    
    @IBAction func navigateToAuth(_ sender: Any) {
        if AuthDataProvider.isUserLoggedIn {
            AuthRouter.goToHomePage(vc: self)
        } else {
            AuthRouter.shared.invokeLoginFlow(onNavigationStack: self.navigationController) { (isLoggedIn, error) in
                print("From Main - User Logged In Successfully")
                AuthRouter.goToHomePage(vc: self)
            }
        }
    }
}

class AuthModuleHelper: AuthModuleUIProtocol {
    func userLoggedInSuccessfully() {
        
    }
    
    func userLoggedOutSuccessfully() {
        
    }
    

    func rewardsDataUpdated() {
        
    }
    
    
    func navigateToEarn() {
        
    }
    
    func showToastMessage(on view: UIViewController, message: String, duration: CGFloat, position: String) {
        print("MESSAGE : \(message)")
    }
    
    
    func setImage(for imageView: UIImageView, url: URL?, placeholder: UIImage?, completionBlock: (() -> Void)?) {
        guard let url = url else { return }
        
        imageView.image = placeholder
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            imageView.image = UIImage(data: data!)
            completionBlock?()
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
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            imageView.image = UIImage(data: data!)
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



