//
//  LoginWelcomeViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

typealias LoginCompletionBlock = (Bool, NSError) -> ()

class LoginWelcomeViewController: LoginBaseViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var enterCodeLabel: UILabel!
    @IBOutlet weak var haveInviteLabel: UILabel!
    @IBOutlet weak var constraintTableViewBottomSpace: NSLayoutConstraint!
    
    var presenter: LoginWelcomePresenter!
    
    var isUserLoggingIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.performInitialConfiguration()
        configureUserInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func configureUserInterface() {
        haveInviteLabel
            .setColor(color: .customGray)
            .setFont(fontType: .regular, size: 14)
        
        enterCodeLabel
            .setColor(color: .customBlue)
            .setFont(fontType: .semiBold, size: 15)
            .addTapGesture(#selector(enterReferralCodeTapped), target: self)
        
        topView
            .setBackgroundColor(color: .customBlue)
        
        resetReferralCode()
    }
    
    @objc func enterReferralCodeTapped() {
        presenter.logGAClickEvent("enter_referral_code")
        let alert = AuthAlert.showReferralCodeAlert(view: self, success: { [weak self] (referralCode) in
            self?.enterCodeLabel.text = referralCode ?? Constants.kEmptyString
            self?.presenter?.validateReferralCode(_referralCode: referralCode!, isBranchFlow: false)
        }) {
            
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetReferralCode(){
        presenter.resetReferralCode()
        if let _ = presenter.branchDictionary {
            haveInviteLabel.text = Constants.kReferralCode
            enterCodeLabel.text = presenter.referralCode
            enterCodeLabel.isUserInteractionEnabled = false
        } else {
            haveInviteLabel.text = Constants.kInviteReferralText
            enterCodeLabel.text = Constants.kEnterCode
            enterCodeLabel.isUserInteractionEnabled = true
        }
        myTable.reloadData()
    }
}

extension LoginWelcomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellType = self.presenter?.dataSource[indexPath.section][indexPath.row] else {
            return UITableViewCell()
        }
        
        switch cellType {
            
        case .welcomeLogo:
            let cell: LoginWelcomeHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        case .orLabelCell:
            let cell: LoginOrTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        case .newUserDetails:
            let cell: LoginNewUserDetailsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
            return cell
            
        case .fbloginCell:
            let cell: LoginFBSingupTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        case .skipNow:
            let cell: LoginSkipNowTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = self.presenter.dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        return cellType.height
    }
    
    func validateReferralCode(_ code: String, completionBlock: @escaping LoginCompletionBlock){
        ActivityIndicator.show(on: self.view)
        presenter.validateReferralCode(_referralCode: self.presenter.referralCode, isBranchFlow: true)
    }
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData?) {
        hideActivityIndicator()
        self.enterCodeLabel.text = presenter.referralCode
        
        if isUserLoggingIn {
            verifyMobileWithNumber(presenter.currentMobileNumber!)
        }
        isUserLoggingIn = false
    }
    
    func verifyReferralRequestFailed(response: ErrorData?) {
        hideActivityIndicator()
        handleError(response)
        resetReferralCode()
    }
    
    func verifyMobileNumberRequestFailed(error: ErrorData?) {
        hideActivityIndicator()
        handleError(error)
    }
    
    func verifyMobileWithNumber(_ mobileNo:String) {
        
        self.view.endEditing(true)
        
        if presenter.isFbSignup {
            //self.requestFBOTPWithMobileNo(mobileNo)
            return
        }
        
        ActivityIndicator.show(on: self.view)
        presenter.verifyMobileNumber(number: mobileNo)
    }
    
    func hideActivityIndicator() {
        ActivityIndicator.hide(on: self.view)
    }
    
    //MARK - Whatsapp Login
    func connectWithWhatsapp() {
        SignInGAPManager.signinOrSignUpEvent(withEventType: .startedSignIn, withMethod: .whatsApp, withVerifyType: nil, withOtherDetails: ["from_page":"Welcome_Page"])
        self.presenter.logGAClickEvent("whatsapp_button")
        WhatsAppManager.shared.referralCode = presenter.referralCode
        WhatsAppManager.shared.delegate = self
        AuthDepedencyInjector.uiDelegate?.showActivityIndicator(on: self.view, withMessage: "Logging in with Whatsapp..")
        WhatsAppManager.shared.loginWithWhatsapp(referralCode: presenter.referralCode)
    }
    
    //MARK: FB Login
    func connectWithFB() {
        
        self.presenter.isFbSignup = true
        SignInGAPManager.signinOrSignUpEvent(withEventType: .startedSignIn, withMethod: .facebook, withVerifyType: nil, withOtherDetails: ["from_page":"Welcome_Page"])
        self.presenter.logGAClickEvent("facebook_button")
        //new FB API need to integreate here
        if let referralCode = self.presenter.referralCode, let _ = self.presenter.branchDictionary  {
            self.validateReferralCode(referralCode, completionBlock: {[weak self] (success, error) in
                guard success == true else {
                    return
                }

                //self?.signInWithFB(isForceLinkFb: nil, referralCode:self?.model.referralCode)
            })
        }
        else{
            //signInWithFB(isForceLinkFb: nil, referralCode:self.model.referralCode)
        }
    }
}

extension LoginWelcomeViewController: LoginNewUserDetailsCellDelegate {
    func didSelectedNewUserLogin(with mobileNumber: String) {
        SignInGAPManager.startTime()
        self.presenter.logGAClickEvent("mobile_continue")
        self.presenter.isFbSignup = false
        
        guard self.presenter.checkMobileValidity(mobileNumber: mobileNumber) else {
            AuthUtils.showAlert(on: self, message: Constants.kInvalidNumberMessage)
            return
        }

        isUserLoggingIn = true
        presenter.currentMobileNumber = mobileNumber
        
        if let referralCode = presenter.referralCode, let _ = presenter.branchDictionary {
            validateReferralCode(referralCode) { [weak self] (success, error) in
                self?.verifyMobileWithNumber(mobileNumber)
            }
        } else {
            verifyMobileWithNumber(mobileNumber)
        }
        
    }
}

extension LoginWelcomeViewController: WhatsappHelperDelegate {
    func loginSuccessful(verifiedData: OtpVerifiedData?, extraKeys: String?) {
        
    }
    
    func loginFailed(error: Any?) {
        
    }
}
