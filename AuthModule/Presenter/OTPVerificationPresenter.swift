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
    var isFbSignup: Bool
    var referralCode: String
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
         isFbSignup: Bool,
         isNewUser: Bool,
         isverifyMethodOtp: Bool,
         referralCode: String) {
        self.mobileNumber = mobileNumber
        self.isNewUser = isNewUser
        self.isFbSignup = isFbSignup
        self.nonce = nonce
        self.referralCode = referralCode
        SignInGAPManager.logOpenScreenEvent(for: .enterOTP, otherParams: ["userType":isNewUser ? "new_user": "existing_user", "medium":self.isFbSignup ? "facebook" :"mobile"])
    }
    
    
    func logGAClickEvent(for type:String) {
        var attributes:Dictionary<String,Any> =  [:]
        attributes["interactionEvent"] = type
        attributes["userType"] = isNewUser ? "new_user":"existing_user"
        attributes["medium"] = isFbSignup ? "facebook" :"mobile"
        attributes["resendTries"] = totalResentCount
        SignInGAPManager.logClickEvent(for: .enterOTP, otherParams: attributes)
    }
    
    fileprivate func logGAVerificationEvent() {
        var attributes:Dictionary<String,Any> =  [:]
        attributes["userType"] = isNewUser ? "new_user": "existing_user"
        attributes["medium"] = self.isFbSignup ? "facebook" : "mobile"
        attributes["resendTries"] = totalResentCount
        let seconds = Int(SignInGAPManager.getTimeInterval())
        attributes["timeTillVerification"] = seconds
        
        SignInGAPManager.logGenericEvent(for: .enterOTP, action: "verificationComplete", otherParams: attributes)
    }
    
    func verifyOTP(withOtp otp:String) {
        interactor?.verifyOtp(mobileNumber, withOtp: otp, nonce: nonce ?? "", isFBSignup: isFbSignup, referralCode: referralCode)
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
                SignInGAPManager.signinOrSignUpEvent(withEventType: .signUp, withMethod: isFbSignup ? .facebook : .phone, withVerifyType: .otp, withOtherDetails: ["referral_code": referralCode])
            } else if userVerificationData?.isExistingUser == true {
                if isFbSignup == true {
                    SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .facebook, withVerifyType: .otp, withOtherDetails: nil)
                } else {
                    SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .phone, withVerifyType: .otp, withOtherDetails: nil)
                    SignInGAPManager.logGenericEventWithoutScreen(for: "loginSuccessNew", otherParams: ["medium":"mobile","verificationChannel":"otp"])
                }
            }
            //<NITIN>view?.userSuccessfullyLoggedIn()
        } else {
            let signupView = router?.navigateToSignUpController(referralCodde: self.referralCode, otpResponse: data)
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
}
