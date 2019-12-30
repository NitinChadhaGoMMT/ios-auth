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
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var enterCodeLabel: UILabel!
    @IBOutlet weak var haveInviteLabel: UILabel!
    
    var presenter: LoginWelcomeViewToPresenterProtocol?
    
    var isUserLoggingIn = false
    
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
    
    override func addMconnectView(){
        if let view: MConnectPoweredByView = Bundle.loadNib() {
            view.layoutIfNeeded()
            self.myTable.layoutIfNeeded()
            self.myTable.tableFooterView = view
        }
    }
    
    @objc func enterReferralCodeTapped() {
        presenter?.logGAClickEvent("enter_referral_code")
        let alert = AuthAlert.showReferralCodeAlert(view: self, success: { [weak self] (referralCode) in
            self?.enterCodeLabel.text = referralCode ?? Constants.kEmptyString
            self?.presenter?.validateReferralCode(_referralCode: referralCode!, isBranchFlow: false)
        }) {
            
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetReferralCode(){
        presenter?.resetReferralCode()
        if let _ = presenter?.branchDictionary {
            haveInviteLabel.text = Constants.kReferralCode
            enterCodeLabel.text = presenter?.referralCode
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
            cell.delegate = self
            return cell
            
        case .skipNow:
            let cell: LoginSkipNowTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = self.presenter?.dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row] else { return 44.0 }
        return cellType.height
    }
    
    func validateReferralCode(_ code: String, completionBlock: @escaping LoginCompletionBlock){
        presenter?.validateReferralCode(_referralCode: self.presenter?.referralCode, isBranchFlow: true)
    }
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData?) {
        self.enterCodeLabel.text = presenter?.referralCode
        
        if isUserLoggingIn {
            verifyMobileWithNumber(presenter?.currentMobileNumber ?? "")
        }
        isUserLoggingIn = false
    }
    
    func verifyReferralRequestFailed(response: ErrorData?) {
        handleError(response)
        resetReferralCode()
    }
    
    func verifyMobileNumberRequestFailed(error: ErrorData?) {
        handleError(error)
    }
    
    func verifyMobileWithNumber(_ mobileNo:String) {
        
        self.view.endEditing(true)
        
        isFbSignup ? self.requestFBOTPWithMobileNo(mobileNo) : presenter?.verifyMobileNumber(number: mobileNo)
    }
    
    //MARK - Whatsapp Login
    func connectWithWhatsapp() {
        SignInGAPManager.signinOrSignUpEvent(withEventType: .startedSignIn, withMethod: .whatsApp, withVerifyType: nil, withOtherDetails: ["from_page":"Welcome_Page"])
        self.presenter?.logGAClickEvent("whatsapp_button")
        WhatsAppManager.shared.referralCode = referralCode
        WhatsAppManager.shared.delegate = self
        AuthDepedencyInjector.uiDelegate?.showActivityIndicator(on: self.view, withMessage: "Logging in with Whatsapp..")
        WhatsAppManager.shared.loginWithWhatsapp(referralCode: presenter?.referralCode)
    }
}

extension LoginWelcomeViewController: LoginNewUserDetailsCellDelegate {
    func didSelectedNewUserLogin(with mobileNumber: String) {
        SignInGAPManager.startTime()
        self.presenter?.logGAClickEvent("mobile_continue")
        self.isFbSignup = false
        
        guard self.presenter?.isValidPhoneNumber(mobileNumber: mobileNumber) ?? false else {
            AuthUtils.showAlert(on: self, message: Constants.kInvalidNumberMessage)
            return
        }

        isUserLoggingIn = true
        presenter?.currentMobileNumber = mobileNumber
        
        if let referralCode = presenter?.referralCode, let _ = presenter?.branchDictionary {
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

extension LoginWelcomeViewController: LoginFBSingupTableCellDelegate {
    //MARK: FB Login
    func connectWithFB() {
        
        self.isFbSignup = true
        SignInGAPManager.signinOrSignUpEvent(withEventType: .startedSignIn, withMethod: .facebook, withVerifyType: nil, withOtherDetails: ["from_page":"Welcome_Page"])
        self.presenter?.logGAClickEvent("facebook_button")
        
        if let referralCode = self.presenter?.referralCode, let _ = self.presenter?.branchDictionary  {
            self.validateReferralCode(referralCode, completionBlock: { [weak self] (success, error) in
                guard success == true else {
                    return
                }
                self?.signInWithFB(isForceLinkFb: nil, referralCode:self?.presenter?.referralCode)
            })
        }
        else{
            signInWithFB(isForceLinkFb: nil, referralCode:self.presenter?.referralCode)
        }
    }
}
