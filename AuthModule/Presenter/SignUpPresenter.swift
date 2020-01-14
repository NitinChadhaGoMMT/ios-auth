
//
//  SignUpPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 11/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

fileprivate enum Referral: Int {
    case none = 0
    case referred = 1
    case user = 2
}

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

class SignUpPresenter: BasePresenter, SignUpViewToPresenterProtocol, SignUpInteractorToPresenterProtocol {
    
    weak var view: SignUpPresenterToViewProtocol?
    
    var interactor: SignUpPresenterToInteractorProtocol?
    
    var fullName: String?
    var mobileKey: String?
    var existingFbId: String?
    var isWhatsappLogin: Bool = false
    var extraKeys:String?
    var earnedGoCash = 0
    
    fileprivate var referralType: Referral = .none
    
    var isValidName: Bool {
        guard let fullName = fullName, !fullName.isEmpty else {
            return false
        }
        return true
    }
    
    init(data: PresenterCommonData, _extraKeys: String? = nil) {
        super.init(dataModel: data)
        self.extraKeys = _extraKeys
        self.mobileKey = userVerificationData?.mobileKey
        self.existingFbId = userVerificationData?.facebookId
        logGAScreenLoadEvent()
    }
    
    func requestSignUp() {
        
        self.logGAClickEvent(for: "continue_button")
        
        guard let fullName = fullName, !fullName.isEmpty  else { return }
        
        view?.showActivityIndicator()
        interactor?.requestToSignUp(fullName, mobileKey: mobileKey ?? Constants.kEmptyString, referalCode: referralCode ?? "", isWhatsAppFlow: isWhatsappLogin, extraKey: extraKeys)
    }
    
    func setReferralCode(code: String?) {
        referralCode = code
        referralType = .user
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
    
    func showReferralCodeInputView() {
        if let new_vc = AuthRouter.shared.presentReferralCodeAlert(delegate: self) {
            view?.present(screen: new_vc)
        }
    }
    
    func signUpRequestFailed(error: ErrorData?) {
        view?.hideActivityIndicator()
        
        if let errorObject = error, errorObject.referalErrorMsg != nil {
            AuthAlert.showIBSVAlert(withTitle:"", msg: errorObject.referalErrorMsg ?? "", confirmTitle: "Continue", cancelTitle: nil, onCancel: {
            }, onConfirm: { [weak self] in
                self?.referralCode = ""
                self?.requestSignUp()
            })
        } else {
            view?.showError(error)
        }
    }
    
    func handleSuccessData(_ data: OtpVerifiedData?) {
        
        view?.logInSuccessfully()
        view?.signUpSuccessfully()
        
        earnedGoCash = data?.userData?.referralBonus?.goCashEarned ?? 0
        referralCode = data?.userData?.referralBonus?.code
        AuthUtils.removeBranchReferCode()
        AuthRouter.shared.signupSuccessNavigationHandling(navigationController: view?.baseNavigationController)
    }
}

//MARK: Analytics
extension SignUpPresenter {
    
    fileprivate func logGAScreenLoadEvent() {
        var attributes:Dictionary<String,Any> =  [:]
        if FireBaseHandler.getBoolFor(keyPath: .showFb, dbPath: .goAuthDatabase) ?? false {
            attributes["linkFacebookEnabled"] = "1"
        } else {
            attributes["linkFacebookEnabled"] = "0"
        }
        attributes["skipEnabled"] = "0"
        attributes["medium"] = isWhatsappLogin ? "whatsapp" : "mobile"
        attributes["verificationChannel"] = isverifyMethodOtp ? "otp" :"mconnect"
        attributes["userDetailsAvailable"] = "FULLNAME"
        attributes["referredInstall"] = "\(referralType.rawValue)"

        SignInGAPManager.logOpenScreenEvent(for: .createAccount, otherParams: attributes)
        SignInGAPManager.logOpenScreenEventWithExplictEventName(for: "Onboarding_Signup_Start", screenType: .createAccount, otherParams:attributes)
    }
    
    fileprivate func logGAClickEvent(for type:String) {
        var attributes:Dictionary<String,Any> =  [:]
        attributes["itemSelected"] = "enter_details"
        attributes["interactionEvent"] = type
        attributes["linkFacebookEnabled"] = "0"
        attributes["skipEnabled"] = "0"
        attributes["medium"] = isWhatsappLogin ? "whatsapp" : "mobile"
        attributes["verificationChannel"] = isverifyMethodOtp ? "otp" :"mconnect"
        attributes["userDetailsAvailable"] = "FullName"
        attributes["referredInstall"] = "\(referralType.rawValue)"
        SignInGAPManager.logClickEvent(for: .createAccount, otherParams: attributes)
    }
}

extension SignUpPresenter: ReferralCodeProtocol {
    func applyReferralCode(code: String) {
        setReferralCode(code: code)
        view?.refreshReferralCodeView()
    }
}
