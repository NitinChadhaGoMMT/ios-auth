
//
//  SignUpPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 11/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class CTAItem: NSObject {
    var tagId: Int?
    var goData: [String:Any]?
    var text: String?
    
    init(dict: [String:Any]){
        text = dict["txt"] as? String
        goData = dict["gd"] as? [String:Any]
        tagId = dict["tag"] as? Int
    }
}

class SignUpPresenter {
    
    weak var view: SignupViewController?
    
    var interactor: SignupInteractor?
    
    var fullName: String?
    var mobileKey: String?
    var existingFbId: String?
    var referralCode: String?
    var isWhatsappLogin: Bool = false
    var extraKeys:String?
    var earnedGoCash = 0
    
    var isValidName: Bool {
        guard let fullName = fullName, !fullName.isEmpty else {
            return false
        }
        return true
    }
    
    init(referralCode: String, otpResponse: OtpVerifiedData?) {
        self.mobileKey = otpResponse?.mobileKey
        self.existingFbId = otpResponse?.facebookId
        self.referralCode = referralCode
    }
    
    func requestSignUp() {
        
        guard let fullName = fullName, !fullName.isEmpty  else { return }
        
        view?.showActivityIndicator()
        interactor?.requestToSignUp("Nitin Chadha", mobileKey: mobileKey ?? Constants.kEmptyString, referalCode: referralCode ?? "", isWhatsAppFlow: isWhatsappLogin, extraKey: extraKeys)
        
    }
    
    func signUpRequestSuccess(otpVerifiedData: OtpVerifiedData?) {
        
        view?.hideActivityIndicator()
        
        guard let otpVerifiedData = otpVerifiedData else {
            view?.userSuccessfullyLoggedIn()
            return
        }
        
        var dict: [String: Any] = ["referral_code": referralCode ?? ""]
        
        if let authParams = AuthCache.shared.getUserDefaltObject(forKey: "auth_params") as? Dictionary<String, Any> {
            for key in authParams.keys {
                dict[key] = authParams[key]
            }
        }
        
        SignInGAPManager.signinOrSignUpEvent(withEventType: .signUp, withMethod: isWhatsappLogin ? .whatsApp : .phone, withVerifyType: isWhatsappLogin ? .whatsapp : .otp, withOtherDetails: dict)
        handleSuccessData(otpVerifiedData)
    }
    
    func signUpRequestFailed(error: ErrorData?) {
        view?.hideActivityIndicator()
        
        if let errorObject = error, errorObject.referalErrorMsg != nil {
            AuthAlert.showIBSVAlert(withTitle:"", msg: errorObject.referalErrorMsg ?? "", confirmTitle: "Continue", cancelTitle: nil, onCancel: {
            }, onConfirm: {
                referralCode = ""
                requestSignUp()
            })
        } else {
            view?.showError(error)
        }
    }
    
    fileprivate func logUserSignUpEvent() {
        var attributes:Dictionary<String,Any> =  [:]
        attributes["medium"] = isWhatsappLogin ? "whatsapp" : "mobile"
        attributes["verificationChannel"] = ( view?.isverifyMethodOtp ?? false ) ? "otp" :"mconnect"
        attributes["referredInstall"] = ( referralCode == "" ? "0" : "1" )
        
        SignInGAPManager.logGenericEventWithoutScreen(for: "signUpSuccessNew", otherParams: attributes)
        SignInGAPManager.logGenericEventWithExplictEventNameWithoutScreen(for: "Onboarding_Signup_Success", action: "signUpSuccessNew", otherParams: attributes)
    }
    
    func handleSuccessData(_ data: OtpVerifiedData?) {
        
        view?.logInSuccessfully()
        view?.signUpSuccessfully()
        
        earnedGoCash = data?.userData?.referralBonus?.goCashEarned ?? 0
        referralCode = data?.userData?.referralBonus?.code
        AuthUtils.removeBranchReferCode()
        AuthRouter.shared.signupSuccessNavigationHandling(cta: nil, navigationController: view?.navigationController)
    }
}
