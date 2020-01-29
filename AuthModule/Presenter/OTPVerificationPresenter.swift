//
//  OTPVerificationPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 09/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class OTPVerificationPresenter: BasePresenter, OTPVerificationViewToPresenterProtocol, OTPVerificationInteractorToPresenterProtocol {
    
    var isNewUser: Bool
    var mobileNumber: String
    var nonce: String?

    fileprivate var whatsAppShowCount = FireBaseHandler.getIntFor(keyPath: .wtsAppShowCount, dbPath: .goAuthDatabase) ?? 2
    
    weak var view: OTPVerificationPresenterToViewProtocol?
    var interactor: OTPVerificationInteractor?
    weak var router: AuthRouter?
    
    var otpResendCount: Int = 0
    
    init(mobileNumber: String,
         nonce: String?,
         isNewUser: Bool,
         data: PresenterCommonData) {
        self.mobileNumber = mobileNumber
        self.isNewUser = isNewUser
        self.nonce = nonce
        super.init(dataModel: data)
        SignInGAPManager.logOpenScreenEvent(for: .enterOTP, otherParams: ["userType":isNewUser ? "new_user": "existing_user", "medium": isFbSignup ? "facebook" :"mobile"])
    }
    
    func shouldShowWhatsappLogin() -> Bool {
        return otpResendCount >= whatsAppShowCount && FireBaseHandler.getRemoteFunctionBoolValue(forKey: "wtsApp_Otp_Enable")
    }
    
    func logGAClickEvent(for type:String) {
        var attributes:Dictionary<String,Any> =  [:]
        attributes["interactionEvent"] = type
        attributes["userType"] = isNewUser ? "new_user":"existing_user"
        attributes["medium"] = isFbSignup ? "facebook" :"mobile"
        attributes["resendTries"] = otpResendCount
        SignInGAPManager.logClickEvent(for: .enterOTP, otherParams: attributes)
    }
    
    fileprivate func logGAVerificationEvent() {
        var attributes:Dictionary<String,Any> =  [:]
        attributes["userType"] = isNewUser ? "new_user": "existing_user"
        attributes["medium"] = isFbSignup ? "facebook" : "mobile"
        attributes["resendTries"] = otpResendCount
        let seconds = Int(SignInGAPManager.getTimeInterval())
        attributes["timeTillVerification"] = seconds
        
        SignInGAPManager.logGenericEvent(for: .enterOTP, action: "verificationComplete", otherParams: attributes)
    }
    
    func verifyOTP(withOtp otp:String) {
        interactor?.verifyOtp(mobileNumber, withOtp: otp, nonce: nonce ?? "", isFBSignup: isFbSignup, referralCode: referralCode ?? "")
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
                SignInGAPManager.signinOrSignUpEvent(withEventType: .signUp, withMethod: isFbSignup ? .facebook : .phone, withVerifyType: .otp, withOtherDetails: [Keys.referralCode: referralCode ?? ""])
            } else if userVerificationData?.isExistingUser == true {
                if isFbSignup == true {
                    SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .facebook, withVerifyType: .otp, withOtherDetails: nil)
                } else {
                    SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .phone, withVerifyType: .otp, withOtherDetails: nil)
                    SignInGAPManager.logGenericEventWithoutScreen(for: "loginSuccessNew", otherParams: ["medium":"mobile","verificationChannel":"otp"])
                }
            }
            view?.userSuccessfullyLoggedIn(verificationData: userVerificationData)
        } else {
            navigateToSignUpScreen(extraKeys: nil)
        }
    }
    
    func navigateToSignUpScreen(extraKeys: String?) {
        if let new_vc = router?.navigateToSignUpController(data: commonData) {
            self.view?.push(screen: new_vc)
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
