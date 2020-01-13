//
//  LoginWelcomeViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

typealias LoginCompletionBlock = (Bool, NSError) -> ()

class LoginWelcomeViewController: LoginBaseViewController, LoginWelcomePresenterToViewProtocol {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var myTable: UITableView!
    
    var presenter: LoginWelcomeViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.performInitialConfiguration()
        configureUserInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        KeychainLoginHandler.shared.presentKeyChainLogin(sender: self)
    }
    
    func configureUserInterface() {
        topView
            .setBackgroundColor(color: .customBlue)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginWelcomeViewController.updateAfterKeychainSuccess), name: NSNotification.Name(rawValue: "ChainUpdate"), object: nil)
        validateReferralCode()
    }
    
    override func addMconnectView(){
        
        if let view: MConnectPoweredByView = Bundle.loadNib() {
            view.layoutIfNeeded()
            self.myTable.layoutIfNeeded()
            self.myTable.tableFooterView = view
        }
    }
    
    func validateReferralCode() {
        if let referralCode = presenter?.referralCode, !referralCode.isEmpty {
            presenter?.validateReferralCode(_referralCode: referralCode, isBranchFlow: true)
        }
    }
    
    override func handleMConnectSuccessData(_ responseData: Any?, mobileNo: String) {
        if let data = responseData as? MconnectVerifiedData {
            presenter?.currentMobileNumber = mobileNo
            if let verificationData = data.mobileVerifiedData, verificationData.isSuccess == true {
                presenter?.navigateToPostMobileNumberScreen(verifiedData: verificationData)
            }
            else if let otpVerifiedData = data.otpVerifiedData, otpVerifiedData.isSuccess == true {
                presenter?.isverifyMethodOtp = true
                presenter?.userVerificationData = otpVerifiedData
                if otpVerifiedData.userStatusType == .loggedIn || otpVerifiedData.userStatusType == .verified {
                    SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .phone, withVerifyType: .mconnect, withOtherDetails: nil)
                    SignInGAPManager.logGenericEventWithoutScreen(for: "loginSuccessNew", otherParams:["medium":"mobile","verificationChannel":"mconnect"])
                    self.userSuccessfullyLoggedIn()
                } else {
                    presenter?.navigateToSignUpScreen()
                }
            } else {
                self.verifyMobileWithNumber(mobileNo)
            }
        } else{
            self.verifyMobileWithNumber(mobileNo)
        }
    }
    
    override func handleMConnectFailure(mobileNo: String) {
        self.verifyMobileWithNumber(mobileNo)
    }
    
    @IBAction func clickedPrivacyPolicy(_ sender: Any) {
        presenter?.navigateToPrivacyPolicy()
    }
    
    @IBAction func clickedUserAgreement(_ sender: Any) {
        presenter?.navigateToUserAgreement()
    }
    
    @IBAction func clickedTC(_ sender: Any) {
        presenter?.navigateToTermsAndConditions()
        
    }
}

extension LoginWelcomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellType = self.presenter?.dataSource[indexPath.section][indexPath.row] else {
            return UITableViewCell()
        }
        
        switch cellType {
            
        case .welcomeLogo:
            let cell: LoginWelcomeTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        case .newUserDetails:
            let cell: LoginNewUserDetailsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
            if presenter?.showReferralStatus ?? false {
                let name = presenter?.branchDictionary?.object(forKey: "fname") as? String ?? "Nitin Chadha"
                cell.configureReferralView(with: name)
            } else {
                cell.configureGenericReferralView()
            }
            return cell
            
        case .whatsappCell:
            let cell: SocialAccountLoginCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.whatsAppButton.addTarget(self, action: #selector(connectWithWhatsapp), for: .touchUpInside)
            cell.faceBookButton.addTarget(self, action: #selector(connectWithFB), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = self.presenter?.dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row] else { return 44.0 }
        return cellType.height
    }
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData) {
        myTable.reloadData()
        AuthAlert.showToastMessage(on: self, message: "Referral Code applied!")
    }
    
    func verifyReferralRequestFailed(response: ErrorData?) {
        AuthAlert.showToastMessage(on: self, message: "Invalid Code. Add this later on.")
    }
    
    func verifyMobileNumberRequestFailed(error: ErrorData?) {
        hideActivityIndicator()
        showError(error)
    }
    
    func verifyMobileWithNumber(_ mobileNo:String) {
        self.view.endEditing(true)
        presenter?.verifyMobileNumber(number: mobileNo)
    }
    
    @objc func updateAfterKeychainSuccess(){
        self.userSuccessfullyLoggedIn()
        self.presenter?.logGAClickEvent("keychain_popup")
    }
}

extension LoginWelcomeViewController: LoginNewUserDetailsCellDelegate {
    func continueButtonAction(with mobileNumber: String) {
        SignInGAPManager.startTime()
        self.presenter?.logGAClickEvent("mobile_continue")
        self.presenter?.isFbSignup = false
        
        guard self.presenter?.isValidPhoneNumber(mobileNumber: mobileNumber) ?? false else {
            AuthUtils.showAlert(on: self, message: Constants.kInvalidNumberMessage)
            return
        }

        presenter?.currentMobileNumber = mobileNumber
        
        if self.mconnectData != nil {
            self.verifymConnectDataWithMobileNo(mobileNumber, isFbSignup: presenter?.isFbSignup ?? false, referralCode: presenter?.referralCode ?? "")
        } else {
            self.verifyMobileWithNumber(mobileNumber)
        }
    }
    
}

extension LoginWelcomeViewController: WhatsappHelperDelegate {
    
    @objc func connectWithWhatsapp() {
        SignInGAPManager.logOpenScreenEventWithExplictEventName(for: "Onboarding_SocialAccounts_Click", screenType: .welcome, otherParams:[:])
        SignInGAPManager.signinOrSignUpEvent(withEventType: .startedSignIn, withMethod: .whatsApp, withVerifyType: nil, withOtherDetails: ["from_page":"Welcome_Page"])
        self.presenter?.logGAClickEvent("whatsapp_button")
        WhatsAppManager.shared.referralCode = presenter?.referralCode ?? ""
        WhatsAppManager.shared.delegate = self
        AuthDepedencyInjector.uiDelegate?.showActivityIndicator(on: self.view, withMessage: "Logging in with Whatsapp..")
        WhatsAppManager.shared.loginWithWhatsapp(referralCode: presenter?.referralCode)
    }
    
    //MARK: FB Login
    @objc func connectWithFB() {
        
        presenter?.isFbSignup = true
        
        SignInGAPManager.logOpenScreenEventWithExplictEventName(for: "Onboarding_SocialAccounts_Click", screenType: .welcome, otherParams:[:])
        
        SignInGAPManager.signinOrSignUpEvent(withEventType: .startedSignIn, withMethod: .facebook, withVerifyType: nil, withOtherDetails: ["from_page":"Welcome_Page"])
        presenter?.logGAClickEvent("facebook_button")
        presenter?.signInWithFB()
    }
    
    func loginSuccessful(verifiedData: OtpVerifiedData?, extraKeys: String?) {
        hideActivityIndicator()
        WhatsappHelper.shared.delegate = nil
        presenter?.isWhatsAppLogin = true
        
        if let verifiedData = verifiedData, verifiedData.isExistingUser == false {
            presenter?.userVerificationData = verifiedData
            presenter?.navigateToSignUpScreen()
            self.performSegue(withIdentifier: "pushUserSignupScreenSegue", sender: extraKeys)
        }
        else{
            SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .whatsApp, withVerifyType: .whatsapp, withOtherDetails: nil)
            SignInGAPManager.logGenericEventWithoutScreen(for: "loginSuccessNew", otherParams:["medium":"whatsapp","verificationChannel":"whatsapp"])
            userSuccessfullyLoggedIn()
        }
    }
    
    func loginFailed(error: Any?) {
        hideActivityIndicator()
        showError(error)
        WhatsappHelper.shared.delegate = nil
    }
}
