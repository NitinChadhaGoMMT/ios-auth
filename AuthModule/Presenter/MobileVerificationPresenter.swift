//
//  MobileVerificationPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 30/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class MobileVerificationPresenter: LoginWelcomeInteractorToPresenterProtocol {
    
    var view: MobileVerificationViewController?
    var interactor: LoginWelcomeInteractor?
    var router: LoginWelcomePresenterToRouterProtocol?
    
    var currentMobileNumber: String?
    
    init(mobile: String?) {
        currentMobileNumber = mobile
    }
    
    func checkForMobileConnect() {
        view?.showActivityIndicator()
        interactor?.checkForMobileConnectAPI { [weak self](mConnectData) in
            self?.view?.hideActivityIndicator()
            if let data = mConnectData {
                self?.view?.setMConnectData(data: data)
            }
        }
    }
    
    func verifyMobileNumber(number: String) {
        view?.showActivityIndicator()
        interactor?.verifyMobileNumber(mobileNumber: number)
    }
    
    func verificationMobileNumberRequestFailed(error: ErrorData?) {
        view?.hideActivityIndicator()
        view?.handleError(error)
    }
    
    func verificationMobileNumberRequestSucceeded(response: MobileVerifiedData?) {
        view?.hideActivityIndicator()
        parseMobileVerificationResponse(verificationData: response)
        if let response = response {
            navigateToPostMobileNumberScreen(verifiedData: response)
        }
    }
    
    func navigateToPostMobileNumberScreen(verifiedData: MobileVerifiedData) {
        
        verifiedData.isSendOtp ? navigateToOTPScreen(verifiedData: verifiedData) : navigateToPasswordScreen(verifiedData: verifiedData)

    }
    
    private func parseMobileVerificationResponse(verificationData: MobileVerifiedData?) {
        
    }
    
    func navigateToPasswordScreen(verifiedData: MobileVerifiedData?) {
        let newViewController = router?.navigateToPasswordViewController(userState: .passwordForMobile,
                                                                         referralCode: view?.referralCode ?? Constants.kEmptyString,
                                                                        mobile: currentMobileNumber!,
                                                                        isVerifyOTP: view?.isverifyMethodOtp ?? false)
        view?.push(screen: newViewController!)
    }
    
    func navigateToOTPScreen(verifiedData: MobileVerifiedData) {
        
        let newViewController = router?.navigateToOTPVerificationController(mobileNumber: currentMobileNumber ?? Constants.kEmptyString,
                                                                           nonce: verifiedData.nonce,
                                                                           isFbSignup: view?.isFbSignup ?? false,
                                                                           isNewUser: verifiedData.isExistingUser,
                                                                           isverifyMethodOtp: view?.isverifyMethodOtp ?? false,
                                                                           referralCode: view?.referralCode ?? Constants.kEmptyString)
        view?.push(screen: newViewController!)
    }

}
