//
//  LoginWelcomePresenter_Facebook.swift
//  AuthModule
//
//  Created by Nitin Chadha on 08/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

//MARK: Facebook Login Integation
extension LoginWelcomePresenter {
    
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
    
    func signInWithFB() {
        
        //self.view.endEditing(true)
        
        SignInGAPManager.signinOrSignUpEvent(withEventType: .startedSignIn, withMethod: .facebook, withVerifyType: nil, withOtherDetails: ["from_page":"Welcome_Page"])
        
        var linkFBAccount : Bool? = false
        
        func showDialogToUser(message: String?){
            
            AuthAlert.showIBSVAlert(withTitle: "", msg: message ?? "Mobile No Already Exist", confirmTitle: "Create New Account", cancelTitle: "Link Account", onCancel: {
                linkFBAccount = true
                loginToFaceBookApiCall()
            }, onConfirm: {
                linkFBAccount = false
                self.isFbSignup = true
                loadMobileEntryScreen(with: nil)
            })
        }
        
        func loadMobileEntryScreen(with newMobile:String?){
            
            if let vc = AuthRouter.shared.navigateToMobileVerificationController(mobile: newMobile, data: commonData) {
                view?.push(screen: vc)
            }
        }
        
        func loginToFaceBookApiCall() {
            
            view?.showActivityIndicator()
            //<NITIN>ActivityIndicator.show(on: self.view, withMessage: "verifying..") //URL_ACT_STYLE_FULL_SCREEN_BLUR
            
            AuthService.newSignInWithFacebook(linkFBAccount, referral: self.referralCode, success: { [weak self](data) in
                
                guard let strongSelf = self else { return }
                
                strongSelf.view?.hideActivityIndicator()
                if let response = data as? OtpVerifiedData, response.isSuccess == true {
                    strongSelf.isFbSignup = true
                    strongSelf.userVerificationData = response
                    if response.userStatusType == .fbLinkDialog {
                        showDialogToUser(message: response.message)
                    }
                    else if response.userStatusType == .absent || response.userStatusType == .createAccountWithFBMobile || response.userStatusType == .createAccountWithNewMobile  {
                        if response.fbPhone != nil {
                            //call otp verify screen
                            
                            if strongSelf.view?.mconnectData == nil {
                                strongSelf.requestFBOTPWithMobileNo(response.fbPhone!)
                            } else {
                                strongSelf.view?.verifymConnectDataWithMobileNo(response.fbPhone!, isFbSignup: strongSelf.commonData.isFbSignup, referralCode: strongSelf.commonData.referralCode ?? "")
                            }
                        } else{
                            // call mobile input screen
                            let newMobile = response.newMobile ?? ""
                            loadMobileEntryScreen(with: newMobile)
                        }
                    }
                    else if response.userStatusType == .loggedIn && response.userData?.userInfo?.mobileVerified == false {
                        if response.userData?.userInfo?.fbPhone != nil {
                            //call otp verify screen
                            if strongSelf.view?.mconnectData == nil {
                                strongSelf.requestFBOTPWithMobileNo(response.userData!.userInfo!.fbPhone!)
                            }
                            else{
                                strongSelf.view?.verifymConnectDataWithMobileNo(response.userData!.userInfo!.fbPhone!, isFbSignup: strongSelf.commonData.isFbSignup, referralCode: strongSelf.commonData.referralCode ?? "")
                            }
                        }
                        else{
                            // call mobile input screen
                            let newMobile = response.newMobile ?? ""
                            loadMobileEntryScreen(with: newMobile)
                        }
                    }
                    else{
                        SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .facebook, withVerifyType: .facebook, withOtherDetails: nil)
                        SignInGAPManager.logGenericEventWithoutScreen(for: "loginSuccessNew", otherParams:["medium":"facebook","verificationChannel":"facebook"])
                        self?.view?.userSuccessfullyLoggedIn()
                    }
                }
                else{
                    self?.view?.showError(nil)
                }
            }) { [weak self] (error) in
                
                self?.view?.hideActivityIndicator()
                self?.view?.showError(error)
            }
        }
        
        
        //ActivityIndicator.show(on: self.view, withMessage: "verifying..")
        view?.hideActivityIndicator()
        if GoFacebookManager.shared.isFacebookSessionOpen {
            GoFacebookManager.shared.signOutFromFacebook()
        }
        
        GoFacebookManager.shared.loginToFacebook( completion: { [weak self] (success, error) in
            //ActivityIndicator.hide(on: self?.view)
            self?.view?.hideActivityIndicator()
            if (success) {
                loginToFaceBookApiCall()
            }
            else if let _ = error {
                self?.view?.showError(error)
            }
        })
    }
}

