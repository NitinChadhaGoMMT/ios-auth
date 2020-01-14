//
//  LoginWelcomePresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

enum LoginCellType {
    case welcomeLogo, newUserDetails, whatsappCell
    
    var height: CGFloat {
        switch self {
        case .welcomeLogo:
            return LoginWelcomeTableCell.height
            
        case .newUserDetails:
            return LoginNewUserDetailsCell.height
            
        case .whatsappCell:
            return SocialAccountLoginCell.height
        }
    }
}


class LoginWelcomePresenter: BasePresenter, LoginWelcomeViewToPresenterProtocol {

    weak var view: LoginWelcomePresenterToViewProtocol?
    
    var interactor: LoginWelcomePresenterToInteractorProtocol?
    
    var router: LoginWelcomePresenterToRouterProtocol?
    
    var dataSource: [[LoginCellType]]
    
    var referralFirstName: String?
    var referredInstall = 0
    var showReferralStatus = false
    var currentMobileNumber: String?
    var extraKeys: String?
    
    override init() {
        dataSource = [[.welcomeLogo], [.newUserDetails, .whatsappCell]]
        super.init()
        if let codeDict = AuthDepedencyInjector.branchReferDictionary {
            referralFirstName = codeDict.object(forKey: "fname") as? String
            commonData.referralCode = codeDict.object(forKey: "refercode") as? String
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
    
    func checkForMobileConnect() {
        interactor?.checkForMobileConnectAPI { [weak self](mConnectData) in
            if let data = mConnectData {
                self?.view?.setMConnectData(data: data)
            }
        }
    }
    
    func verifyMobileNumber(number: String) {
        view?.showActivityIndicator()
        if isFbSignup {
            requestFBOTPWithMobileNo(number)
        } else {
            interactor?.verifyMobileNumber(mobileNumber: number)
        }
    }
}

//MARK: interactor?. DELEGATE METHODS
extension LoginWelcomePresenter: LoginWelcomeInteractorToPresenterProtocol {
    
    func verificationMobileNumberRequestSucceeded(response: MobileVerifiedData?) {
        view?.hideActivityIndicator()
        
        if let response = response {
            navigateToPostMobileNumberScreen(verifiedData: response)
        }
    }
    
    func verificationMobileNumberRequestFailed(error: ErrorData?) {
        view?.verifyMobileNumberRequestFailed(error: error)
    }
}

//MARK: NAVIGATION RELATED METHODS
extension LoginWelcomePresenter {
    func navigateToPostMobileNumberScreen(verifiedData: MobileVerifiedData) {
        
        guard let router = router, let mobileNumber = currentMobileNumber else { return }
        
        if verifiedData.isSendOtp {
            if let new_vc = router.navigateToOTPVerificationController(mobile: mobileNumber, data: commonData, nonce: verifiedData.nonce, isNewUser: verifiedData.isExistingUser) {
                view?.push(screen: new_vc)
            }
        } else {
            if let new_vc = router.navigateToPasswordViewController(userState: .passwordOTP, mobile: mobileNumber, data: commonData) {
                view?.push(screen: new_vc)
            }
        }
    }
    
    func navigateToSignUpScreen() {
        if let new_vc = router?.navigateToSignUpController(data: commonData) {
            view?.push(screen: new_vc)
        }
    }
    
    func navigateToTermsAndConditions() {
        if let new_vc = router?.navigateToTermsAndConditions() {
            view?.push(screen: new_vc)
        }
    }
    
    func navigateToPrivacyPolicy() {
        if let new_vc = router?.navigateToPrivacyPolicy() {
            view?.push(screen: new_vc)
        }
    }
    
    func navigateToUserAgreement() {
        if let new_vc = router?.navigateToUserAgreement() {
            view?.push(screen: new_vc)
        }
    }
}

//MARK: GA RELATED METHODS
extension LoginWelcomePresenter {
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
