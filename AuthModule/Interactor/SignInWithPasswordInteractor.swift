//
//  SignInWithPasswordPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 05/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class SignInWithPasswordInteractor: BaseInteractor, SignInWithPasswordPresenterToInteractorProtocol {
    
    weak var presenter: SignInWithPasswordInteractorToPresenterProtocol?
    
    func requestOTP(forMobile mobileNumber: String) {
        AuthService.requestOTPforMobile(mobileNumber, success: { [weak self] (data) in
            guard let response = LoginMobileVerifyParser().parseJSON(data) as? MobileVerifiedData else {
                self?.presenter?.requestOTPFailedResponse(error: nil)
                return
            }
            
            self?.presenter?.requestOTPSuccessResponse(resposne: response)
            
        }) { [weak self] (error) in
            
            self?.presenter?.requestOTPFailedResponse(error: error)
        }
    }
    
    func loginUser(forMobile mobileNumber: String, password: String, referralCode:String) {
        AuthService.loginWithMobileAndPassword(mobileNumber, referralCode: referralCode, withPassword: password, success: { [weak self](data) in
            guard let response = LoginOTPVerifyParser().parseJSON(data) as? OtpVerifiedData else {
                self?.presenter?.requestLoginFailedResponse(error: nil)
                return
            }
            self?.presenter?.requestLoginSuccessResponse(resposne: response)
            
        }) { [weak self](error) in
            self?.presenter?.requestLoginFailedResponse(error: error)
        }
    }
}
