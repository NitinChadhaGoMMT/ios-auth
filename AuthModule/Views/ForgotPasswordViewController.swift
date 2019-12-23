//
//  ForgotPassTableViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 17/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class ForgotPassTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var tfEmailID: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class ForgotPasswordViewController: LoginBaseViewController, ForgotPasswordPresenterToViewProtocol {
    
    @IBOutlet weak var sendResetLinkButton: UIButton!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    var tableVC:ForgotPassTableViewController!
    
    var presenter: ForgotPasswordViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forgot Password"
        backButton.setBackgroundImage(#imageLiteral(resourceName: "backArrowNew"), for: .normal)
        titleImage.image = #imageLiteral(resourceName: "goibiboCopy")
        self.sendResetLinkButton.layer.cornerRadius = 5;
        self.sendResetLinkButton.layer.masksToBounds = true
        tableVC.tfEmailID.text = presenter?.mobile
        tableVC.tfEmailID.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embed_forgot_pass_table" {
            tableVC = segue.destination as? ForgotPassTableViewController
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actForgotPassword(_ sender: Any) {
        
        let emailOrMobile = tableVC.tfEmailID.text;
        
        var postDic = [String: String]()
        
        if AuthUtils.isValidPhoneNumber(emailOrMobile) {
            postDic["mobile"] = emailOrMobile
        } else {
            AuthAlert.showErrorAlert(view: self, title: "GoIbibo", message: "Please enter valid email/mobile")
            return
        }
        presenter?.requestToRegeneratePassword()
    }
    
    func forgotPasswordRequestSuccess(message: String) {
        AuthAlert.showSucessAlert(withMessage: message, view: self) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.navigateToPreviousScreen(view: strongSelf)
        }
    }
    
    func forgotPasswordRequestFailed(message: String) {
        AuthAlert.showErrorAlert(view: self, message: message)
    }

}

