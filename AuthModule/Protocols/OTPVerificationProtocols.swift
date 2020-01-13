//
//  OTPVerificationProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol OTPVerificationViewToPresenterProtocol: BasePresenter {
    
    var mobileNumber: String { get }
    
    var otpResendCount: Int { get set }
    
    func shouldShowWhatsappLogin() -> Bool
    
    func logGAClickEvent(for type: String)
    
    func verifyOTP(withOtp otp:String)
    
    func requestFacebookToResendOTP()
    
    func requestToResendOTP()
    
    func navigateToSignUpScreen(extraKeys: String?)
    
}

protocol OTPVerificationPresenterToViewProtocol: LoginBaseProtocol {

    func verifyOTPRequestSuccessResponse(message: String?)
    
    func requestToResendOTPFailedResponse(error: ErrorData?)
    
    func requestToResendOTPSuccessResponse()
    
    func verifyOTPRequestFailedResponse(error: ErrorData?) 
}

protocol OTPVerificationPresenterToInteractorProtocol: InteractorBaseProtocol {
    
    func verifyOtp(_ mobileNo:String, withOtp otp:String, nonce:String, isFBSignup:Bool, referralCode:String)
    
    func requestToResendOTP(_ mobileNo:String)
    
    func requestFacebookToResendOTP(_ mobileNumber: String)
}

protocol OTPVerificationInteractorToPresenterProtocol: class {
    
    func successResponseFromVerifyOTPRequest(data: OtpVerifiedData?)
    
    func failedResponseFromVerifyOTPRequest(error: ErrorData? )
    
    func successResponseFromResendOTPRequest(data: MobileVerifiedData?)
    
    func failedResponseFromResendOTPRequest(error: ErrorData? )
    
    func requestToResendFBOTPSucceeded(data: MobileVerifiedData?)
    
    func requestToResendFBOTPFailed(error: ErrorData?)
}
