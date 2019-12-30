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
        case .welcomeLogo:
            return LoginWelcomeHeaderCell.height
            
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

class LoginWelcomePresenter: LoginWelcomeViewToPresenterProtocol, LoginWelcomeInteractorToPresenterProtocol {

    weak var view: LoginWelcomePresenterToViewProtocol!
    
    var interactor: LoginWelcomePresenterToInteractorProtocol!
    
    var router: LoginWelcomePresenterToRouterProtocol?
    
    var dataSource: [[LoginCellType]]
    
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
    
    func isValidPhoneNumber(mobileNumber: String?) -> Bool {
        return AuthUtils.isValidPhoneNumber(mobileNumber)
    }
    
    func performInitialConfiguration() {
        if FireBaseHandler.getBoolFor(keyPath: .clearCookieOnLogin) ?? false {
            UserDataManager.shared.clearCookiesAndCache()
        }
        UserDataManager.shared.isWAChecked = false
        logGAScreenLoadEvents()
        checkForMobileConnect()
    }
    
    func resetReferralCode(){
        branchDictionary = nil
        if let codeDict = AuthDepedencyInjector.branchReferDictionary {
            branchDictionary = codeDict
            referralCode = branchDictionary?.object(forKey: "refercode") as? String
        }
    }
    
    func checkForMobileConnect() {
        view.showActivityIndicator()
        interactor.checkForMobileConnectAPI { [weak self](mConnectData) in
            self?.view.hideActivityIndicator()
            if let data = mConnectData {
                self?.view.setMConnectData(data: data)
            }
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
        
        view.hideActivityIndicator()
        
        guard let response = response else {
            resetReferralCode()
            view.resetReferralCode()
            return
        }
        
        referralCode = self.editedReferralCode
        view.verifyReferralSuccessResponse(response: response)
    }
    
    func verifyReferralRequestFailed(error: ErrorData?) {
        view.hideActivityIndicator()
        view.verifyReferralRequestFailed(response: error)
    }
    
    func verifyMobileNumber(number: String) {
        view.showActivityIndicator()
        interactor.verifyMobileNumber(mobileNumber: number)
    }
    
    func verificationMobileNumberRequestSucceeded(response: MobileVerifiedData?) {
        view.hideActivityIndicator()
        parseMobileVerificationResponse(verificationData: response)
        if let response = response {
            navigateToPostMobileNumberScreen(verifiedData: response)
        }
    }
    
    func navigateToPostMobileNumberScreen(verifiedData: MobileVerifiedData) {
        
        guard let router = router, let mobileNumber = currentMobileNumber else { return }
        
        if verifiedData.isSendOtp {
            let newViewController = router.navigateToOTPVerificationController(mobileNumber: mobileNumber,
                                                                               nonce: verifiedData.nonce,
                                                                               isFbSignup: view?.isFbSignup ?? false,
                                                                               isNewUser: verifiedData.isExistingUser,
                                                                               isverifyMethodOtp: view.isverifyMethodOtp,
                                                                               referralCode: self.referralCode ?? Constants.kEmptyString)
            view.push(screen: newViewController!)
        } else {
            let newViewController = router.navigateToPasswordViewController(userState: .passwordOTP,
                                                                            referralCode: referralCode ?? Constants.kEmptyString,
                                                                            mobile: mobileNumber,
                                                                            isVerifyOTP: view.isverifyMethodOtp)
            view.push(screen: newViewController!)
        }
    }
    
    func verificationMobileNumberRequestFailed(error: ErrorData?) {
        view.verifyMobileNumberRequestFailed(error: error)
    }
    
    private func parseMobileVerificationResponse(verificationData: MobileVerifiedData?) {
    
    }
    
    private func getCommonGAAttributes() -> [String: Any] {
        var attributes:Dictionary<String,Any> =  [:]
        attributes["referredInstall"] = referredInstall
        var mediumsEnabled = "MOBILE"
        
        if WhatsAppManager.shared.isWhatsAppLoginEnabled() {
            mediumsEnabled.append(contentsOf: "|FACEBOOK|Whatsapp")
        } else {
            mediumsEnabled.append(contentsOf: "|FACEBOOK")
        }
        
        let dict = FireBaseHandler.getDictionaryFor(keyPath: .onboarding)
        if let status = dict["mc_status3"] as? Bool, status == true {
            mediumsEnabled.append(contentsOf: "|MCONNECT")
        }
        
        attributes["mediumsEnabled"] = mediumsEnabled
        return attributes
    }
    
    private func logGAScreenLoadEvents() {
        SignInGAPManager.logOpenScreenEvent(for: .welcome, otherParams: getCommonGAAttributes())
    }
    
    func logGAClickEvent(_ type:String) {
        var attributes:Dictionary<String,Any> =  getCommonGAAttributes()
        attributes["itemSelected"] = "medium_selection"
        attributes["interactionEvent"] = type
        SignInGAPManager.logClickEvent(for: .welcome, otherParams: attributes)
    }
    
}
