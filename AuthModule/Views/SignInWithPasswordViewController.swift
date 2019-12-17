//
//  SignInWithPasswordViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 05/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class SignInWithPasswordViewController: LoginBaseViewController {

    var presenter: SignInWithPasswordPresenter?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if button.tag == SignInWithPasswordPresenter.SignInCellType.requestOTP.rawValue {
            
        } else {
            signIn(withMobileNo: self.presenter?.mobileNumber, withPassword: self.presenter?.password)
        }
    }
    
    // MARK: - Sign In and OTP
    func signIn(withMobileNo mobileNo:String?, withPassword password:String?) {
        
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
        /*showActivityIndicator()
        AuthInteractor.loginWithMobileAndPassword(mobileNo!, referralCode: self.referralCode, withPassword: password!, success: { [weak self] (data) in
            let otpData = data as? OtpVerifiedData
            self?.hideActivityIndicator()
            self?.userVerificationData = otpData
            if otpData?.userStatusType == .verified || otpData?.userStatusType == .loggedIn {
                
                SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .phone, withVerifyType: .password, withOtherDetails: nil)
                SignInGAPManager.logGenericEventWithoutScreen(for: "loginSuccessNew", otherParams:["medium":"mobile","verificationChannel":"password"])
                self?.userSuccessfullyLoggedIn()

            }
            else {
                //Error
            }
        }) { [weak self] (error) in
            self?.hideActivityIndicator()
            self?.handleError(error)
        }*/
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
        
    }
}
