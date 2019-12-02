//
//  LoginWelcomePresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

enum LoginCellType {
    case welcomeLogo, newUserDetails, skipNow, orLabelCell, fbloginCell, whatsappCell
    
    var height: CGFloat {
        switch self {
        case .newUserDetails:
            return LoginNewUserDetailsCell.height
            
        case .orLabelCell:
            return LoginOrTableCell.height
            
        case .fbloginCell:
            return LoginFBSingupTableCell.height
            
        case .skipNow:
            return LoginSkipNowTableCell.height
            
        default:
            return 44
        }
    }
}

class LoginWelcomePresenter {

    weak var view: LoginWelcomeViewController!
    
    var interactor: LoginWelcomeInteractor!
    
    var dataSource: [[LoginCellType]]
    
    var isFbSignup: Bool = false
    var referralCode: String?
    var branchDictionary: NSDictionary?
    var referredInstall = 0
    var editedReferralCode: String?
    var currentMobileNumber: String?
    
    init() {
        if WhatsAppManager.shared.isWhatsAppLoginEnabled() {
            dataSource =  [[.welcomeLogo], [.newUserDetails,.orLabelCell, .whatsappCell], [.skipNow]]
        } else {
            dataSource = [[.welcomeLogo], [.newUserDetails,.orLabelCell,.fbloginCell], [.skipNow]]
        }
    }
    
    func checkMobileValidity(mobileNumber: String?) -> Bool {
        return AuthUtils.isValidPhoneNumber(mobileNumber)
    }
    
    func performInitialConfiguration() {
        if FireBaseHandler.getBoolFor(keyPath: .clearCookieOnLogin) {
            UserDataManager.shared.clearCookiesAndCache()
        }
        UserDataManager.shared.isWAChecked = false
    }
    
    func resetReferralCode(){
        branchDictionary = nil
        if let codeDict = AuthDepedencyInjector.branchReferDictionary {
            branchDictionary = codeDict
            referralCode = branchDictionary?.object(forKey: "refercode") as? String
        }
    }
    
    func validateReferralCode(_referralCode: String?, isBranchFlow: Bool) {
        
        guard let referralCode = _referralCode else {
            view.hideActivityIndicator()
            return
        }
        
        self.editedReferralCode = referralCode
        interactor.verifyReferralCode(referralCode: referralCode, isBranchFlow: isBranchFlow)
    }
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData?) {
        guard let response = response else {
            view.hideActivityIndicator()
            resetReferralCode()
            view.resetReferralCode()
            return
        }
        
        referralCode = self.editedReferralCode
        view.verifyReferralSuccessResponse(response: response)
    }
    
    func verifyReferralRequestFailed(response: ErrorData?) {
        view.verifyReferralRequestFailed(response: response)
    }
    
    func verifyMobileNumber(number: String) {
        interactor.verifyMobileNumber(mobileNumber: number)
    }
    
    func verificationMobileNumberRequestSucceeded(response: MobileVerifiedData?) {
        view.hideActivityIndicator()
        parseMobileVerificationResponse(verificationData: response)
    }
    
    func verificationMobileNumberRequestFailed(error: ErrorData?) {
        view.verifyReferralRequestFailed(response: error)
    }
    
    private func parseMobileVerificationResponse(verificationData: MobileVerifiedData?) {
        /*
        if verificationData.isSendOtp {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerificationViewController") as? OtpVerificationViewController else {
                return
            }
            controller.mobileNo = self.currentMobileNumber
            controller.nonce = verificationData.nonce
            controller.isFbSignup = self.isFbSignup
            controller.isNewUser = verificationData.isExistingUser
            controller.isverifyMethodOtp = self.isverifyMethodOtp
            controller.referralCode = self.model.referralCode ?? ""
            controller.loginBlock = self.loginBlock
            controller.pushcontroller = self.pushcontroller
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else {
            self.performSegue(withIdentifier: "pushSignInScreenSegue", sender:UserSignInState.passwordOTP)
            //self?.performSegue(withIdentifier: "pushUserSignInScreenSegue", sender: nil)
        }*/
    }
    
}
