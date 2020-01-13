//
//  MobileVerificationPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 30/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class MobileVerificationPresenter: BasePresenter, MobileVerificationViewToPresenterProtocol, LoginWelcomeInteractorToPresenterProtocol {
    
    var view: MobileVerificationPresenterToViewProtocol?
    var interactor: LoginWelcomePresenterToInteractorProtocol?
    var router: LoginWelcomePresenterToRouterProtocol?
    
    var currentMobileNumber: String?
    
    init(mobile: String?, data: PresenterCommonData) {
        currentMobileNumber = mobile
        super.init(dataModel: data)
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
        view?.showError(error)
    }
    
    func verificationMobileNumberRequestSucceeded(response: MobileVerifiedData?) {
        view?.hideActivityIndicator()
        parseMobileVerificationResponse(verificationData: response)
        if let response = response {
            navigateToPostMobileNumberScreen(verifiedData: response)
        }
    }
    
    
    func requestFBOTPWithMobileNo(_ mobileNo: String){
        
        //<NITIN>self.view.endEditing(true)
        
        AuthService.requestFacebookOTPforMobile(mobileNo, success: { [weak self] (data) in
            
            guard let strongSelf = self else { return }
            
            if let response = data as? MobileVerifiedData {
                if let vc = AuthRouter.shared.navigateToOTPVerificationController(mobile: mobileNo, data: strongSelf.commonData, nonce: response.nonce, isNewUser: false) {
                    self?.view?.push(screen: vc)
                }
            }
        }) { [weak self] (error) in
            self?.view?.showError(error)
        }
    }
    
    func navigateToPostMobileNumberScreen(verifiedData: MobileVerifiedData) {
        
        verifiedData.isSendOtp ? navigateToOTPScreen(verifiedData: verifiedData) : navigateToPasswordScreen(verifiedData: verifiedData)

    }
    
    private func parseMobileVerificationResponse(verificationData: MobileVerifiedData?) {
        
    }
    
    func navigateToPasswordScreen(verifiedData: MobileVerifiedData?) {
        if let new_vc = router?.navigateToPasswordViewController(userState: .passwordForMobile, mobile: currentMobileNumber!, data: commonData) {
            view?.push(screen: new_vc)
        }
    }
    
    func navigateToOTPScreen(verifiedData: MobileVerifiedData) {
        if let new_vc = router?.navigateToOTPVerificationController(mobile: currentMobileNumber!, data: commonData, nonce: verifiedData.nonce, isNewUser: verifiedData.isExistingUser) {
            view?.push(screen: new_vc)
        }
    }

}
