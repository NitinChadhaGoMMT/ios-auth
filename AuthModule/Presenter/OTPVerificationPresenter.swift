//
//  OTPVerificationPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 09/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class OTPVerificationPresenter {
    
    var isNewUser: Bool
    var mobileNumber: String
    var nonce: String?
    var totalResentCount = 0
    var userVerificationData: OtpVerifiedData?
    
    weak var view: OtpVerificationViewController?
    var interactor: OTPVerificationInteractor?
    weak var router: AuthRouter?
    
    var otpResendCount: Int = 0
    
    init(mobileNumber: String,
         nonce: String?,
         isNewUser: Bool,
         isverifyMethodOtp: Bool) {
        self.mobileNumber = mobileNumber
        self.isNewUser = isNewUser
        self.nonce = nonce
        SignInGAPManager.logOpenScreenEvent(for: .enterOTP, otherParams: ["userType":isNewUser ? "new_user": "existing_user", "medium": (view?.isFbSignup ?? false) ? "facebook" :"mobile"])
    }
    
    func logGAClickEvent(for type:String) {
        var attributes:Dictionary<String,Any> =  [:]
        attributes["interactionEvent"] = type
        attributes["userType"] = isNewUser ? "new_user":"existing_user"
        attributes["medium"] = (view?.isFbSignup ?? false) ? "facebook" :"mobile"
        attributes["resendTries"] = totalResentCount
        SignInGAPManager.logClickEvent(for: .enterOTP, otherParams: attributes)
    }
    
    fileprivate func logGAVerificationEvent() {
        var attributes:Dictionary<String,Any> =  [:]
        attributes["userType"] = isNewUser ? "new_user": "existing_user"
        attributes["medium"] = (view?.isFbSignup ?? false) ? "facebook" : "mobile"
        attributes["resendTries"] = totalResentCount
        let seconds = Int(SignInGAPManager.getTimeInterval())
        attributes["timeTillVerification"] = seconds
        
        SignInGAPManager.logGenericEvent(for: .enterOTP, action: "verificationComplete", otherParams: attributes)
    }
    
    func verifyOTP(withOtp otp:String) {
        interactor?.verifyOtp(mobileNumber, withOtp: otp, nonce: nonce ?? "", isFBSignup: view?.isFbSignup ?? false, referralCode: view?.referralCode ?? "")
    }
    
    func requestToResendOTP() {
        interactor?.requestToResendOTP(self.mobileNumber)
    }
    
    func successResponseFromVerifyOTPRequest(data: OtpVerifiedData?) {
        logGAVerificationEvent()
        userVerificationData = data
        if userVerificationData?.userStatusType == .loggedIn || userVerificationData?.userStatusType == .verified {
            view?.verifyOTPRequestSuccessResponse(message: userVerificationData?.message)
            if userVerificationData?.isExistingUser == false {
                SignInGAPManager.signinOrSignUpEvent(withEventType: .signUp, withMethod: (view?.isFbSignup ?? false) ? .facebook : .phone, withVerifyType: .otp, withOtherDetails: ["referral_code": view?.referralCode ?? ""])
            } else if userVerificationData?.isExistingUser == true {
                if (view?.isFbSignup ?? false) == true {
                    SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .facebook, withVerifyType: .otp, withOtherDetails: nil)
                } else {
                    SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .phone, withVerifyType: .otp, withOtherDetails: nil)
                    SignInGAPManager.logGenericEventWithoutScreen(for: "loginSuccessNew", otherParams: ["medium":"mobile","verificationChannel":"otp"])
                }
            }
            view?.userSuccessfullyLoggedIn()
        } else {
            let signupView = router?.navigateToSignUpController(referralCodde: view?.referralCode ?? "", otpResponse: data)
            self.view?.navigationController?.pushViewController(signupView!, animated: true)
        }
    }
    
    func failedResponseFromVerifyOTPRequest(error: ErrorData? ) {
        view?.verifyOTPRequestFailedResponse(error: error)
    }
    
    func successResponseFromResendOTPRequest(data: MobileVerifiedData?) {
        guard let responseData = data else {
            view?.requestToResendOTPFailedResponse(error: nil)
            return
        }
        nonce = responseData.nonce
        view?.requestToResendOTPSuccessResponse()
    }
    
    func failedResponseFromResendOTPRequest(error: ErrorData? ) {
        view?.requestToResendOTPFailedResponse(error: error)
    }
    
    func requestFacebookToResendOTP() {
        view?.showActivityIndicator()
        interactor?.requestFacebookToResendOTP(mobileNumber)
    }
    
    func requestToResendFBOTPSucceeded(data: MobileVerifiedData?) {
        view?.hideActivityIndicator()
        if let response = data {
            nonce = response.nonce
        }
    }
    
    func requestToResendFBOTPFailed(error: ErrorData?) {
        view?.hideActivityIndicator()
        view?.showError(error)
    }
}
