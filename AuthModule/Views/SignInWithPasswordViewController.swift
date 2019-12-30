//
//  SignInWithPasswordViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 05/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class SignInWithPasswordViewController: LoginBaseViewController, SignInWithPasswordPresenterToViewProtocol {

    var presenter: SignInWithPasswordViewToPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.performInitialConfiguration()
    }
    
    fileprivate func logGAClickEvent(for type:String) {
        var attributes:Dictionary<String,Any> =  [:]
        attributes["interactionEvent"] = type
        SignInGAPManager.logClickEvent(for: .enterPassword, otherParams: attributes)
    }
    
    @IBAction func backButtonTapped() {
        self.logGAClickEvent(for: "back_button")
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension SignInWithPasswordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = presenter?.dataSource[indexPath.row] else {
            return UITableViewCell()
        }
        
        switch cellType {
        case .singInText:
            let cell:SignInHeaderTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        case .passwordInput:
            let cell: LoginPasswordTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
            return cell
            
        case .signInButton, .requestOTP:
            let cell: LoginContinueTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configureCell(details: cellType)
            cell.continueButton.tag = cellType.rawValue
            cell.continueButton.addTarget(self, action: #selector(continueButtonAction(button:)), for: .touchUpInside)
            return cell
            
        case .orLabelCell:
            let cell: LoginOrTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    @objc func continueButtonAction(button: UIButton) {
        if button.tag == SignInCellType.requestOTP.rawValue {
            requestOtp()
        } else {
            requestForUserLogin()
        }
    }
    
    func requestOtp() {
        self.logGAClickEvent(for: "request_otp")
        if AuthUtils.isEmptyString(presenter?.mobileNumber) {
            AuthAlert.showEmptyMobileErrorAlert(view: self)
            return
        }
        
        self.view.endEditing(true)
        presenter?.requestOTP()
    }
    
    // MARK: - Sign In and OTP
    func requestForUserLogin() {
        
        self.logGAClickEvent(for: "verify_password")
        
        guard let mobileNumber = presenter?.mobileNumber, !mobileNumber.isEmpty else {
            AuthAlert.showEmptyMobileErrorAlert(view: self)
            return
        }
        
        guard let password = presenter?.password, !password.isEmpty else {
            AuthAlert.showEmptyPasswordErrorAlert(view: self)
            return
        }

        self.view.endEditing(true)
        presenter?.logInUser()
    }
    
    func userLoggedInRequestFailed(error: ErrorData?) {
        handleError(error)
    }
    
    func userLoggedInRequestSucceeded(data: OtpVerifiedData?) {
        //AuthAlert.show(message: "LOGGED IN SUCCESSFULLY")
        userSuccessfullyLoggedIn()
    }
    
    func requestOtpFailed(error: ErrorData?) {
        handleError(error)
    }
}

extension SignInWithPasswordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = presenter?.dataSource[indexPath.row] else {
            return 44.0
        }
        
        return cellType.height
    }
}

extension SignInWithPasswordViewController: LoginPasswordCellProtocol {
    func didUpdatedPassword(newPassword: String?) {
        self.presenter?.password = newPassword
    }
    
    func didSelectForgotPassword() {
        presenter?.navigateToForgotPasswordScreen()
    }
}
