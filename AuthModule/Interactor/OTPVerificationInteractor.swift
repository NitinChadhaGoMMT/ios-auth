//
//  OTPVerificationInteractor.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class OTPVerificationInteractor: BaseInteractor {
    
    weak var presenter: OTPVerificationInteractorToPresenterProtocol?
    
    func verifyOtp(_ mobileNo:String, withOtp otp:String, nonce:String, isFBSignup:Bool, referralCode:String) {
        
        AuthService.verifyOtp(mobileNo, withOtp: otp, nonce: nonce, isFBSignup: isFBSignup, referralCode: referralCode, success: { [weak self](data) in
            let response = LoginOTPVerifyParser().parseJSON(data) as? OtpVerifiedData
            self?.presenter?.successResponseFromVerifyOTPRequest(data: response)
        }) { [weak self](errorData) in
            self?.presenter?.failedResponseFromVerifyOTPRequest(error: errorData)
        }
    }
    
    func requestToResendOTP(_ mobileNo:String) {
        
        AuthService.requestToResendOTPforMobile(mobileNo, success: { [weak self](data) in
            let response = LoginMobileVerifyParser().parseJSON(data) as? MobileVerifiedData
            self?.presenter?.successResponseFromResendOTPRequest(data: response)
        }) { [weak self](error) in
            self?.presenter?.failedResponseFromResendOTPRequest(error: error)
        }
    }
    
    func requestFacebookToResendOTP(_ mobileNumber: String) {
        AuthService.requestFacebookToResendOTP(mobileNumber, success: { [weak self] (data) in
            let response = LoginMobileVerifyParser().parseJSON(data) as? MobileVerifiedData
            self?.presenter?.requestToResendFBOTPSucceeded(data: response)
        }) { [weak self](error) in
            self?.presenter?.requestToResendFBOTPFailed(error: error)
        }
    }
    
    
}
