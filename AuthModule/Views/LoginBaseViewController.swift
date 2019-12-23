    //
    //  LoginBaseViewController.swift
    //  AuthModule
    //
    //  Created by Nitin Chadha on 02/12/19.
    //  Copyright © 2019 Nitin Chadha. All rights reserved.
    //
    
import UIKit
    
class LoginBaseViewController: UIViewController, LoginBaseProtocol {
        
    var mconnectData: MconnectData?
    lazy var isverifyMethodOtp = true
    var isFbSignup = false
    var referralCode: String = ""
    var userVerificationData: OtpVerifiedData?
    
    @IBOutlet weak var constraintTableViewBottomSpace: NSLayoutConstraint!
    
        // MARK: Error handling
    func  handleError(_ errorData:Any?) {
            
        guard let errorObject = errorData as? ErrorData else {
            return
        }
        if errorObject.nonFieldErrorMsg != nil {
            AuthAlert.showErrorAlert(view: self, message: errorObject.nonFieldErrorMsg!)
        }  else if  errorObject.fbAccessTknMsg != nil {
            AuthAlert.showErrorAlert(view: self, message: errorObject.fbAccessTknMsg!)
        } else if  errorObject.referalErrorMsg != nil {
            AuthAlert.showErrorAlert(view: self, message: errorObject.referalErrorMsg!)
        } else if  errorObject.userNameErrorMsg != nil {
            AuthAlert.showErrorAlert(view: self, message: errorObject.userNameErrorMsg!)
        } else if  errorObject.errorMsgString != nil {
            AuthAlert.showErrorAlert(view: self, message: errorObject.errorMsgString!)
        } else {
            AuthAlert.showErrorAlert(view: self, message: "Something wrent wrong. Please try again later.")
        }
    }
    
    func getSavedReferralCode() -> NSDictionary? {
        //<NITIN>
        return nil
    }
    
    func userSuccessfullyLoggedIn(){
        /*<NITIN>
        UserDataManager.sharedInstance().didUserLoginInCurrentSession = true
        FireBaseHandler.sharedInstance.getUsersLocalNotificationData()
        UserDataManager.updateLoggedInUserGoCash()
        OfflineReviewsFireBase.sharedInstance.signIn()
        RecentSearchManager.shared.performGuestUserToLoggedInUserRecentSearchMigration()*/
    }
    
    func setMConnectData(data: MconnectData) {
        self.mconnectData = data
        addMconnectView()
    }
    
    func addMconnectView() {
        //override this method
    }
    
    func pushController(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showActivityIndicator() {
        ActivityIndicator.show(on: self.view)
    }
    
    func hideActivityIndicator() {
        ActivityIndicator.hide(on: self.view)
    }
    
    func push(screen: UIViewController) {
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    func requestFBOTPWithMobileNo(_ mobileNo: String){
        
        self.view.endEditing(true)
        
        AuthService.requestFacebookOTPforMobile(mobileNo, success: { [weak self] (data) in
            if let response = data as? MobileVerifiedData {
                if let vc = AuthRouter.shared.navigateToOTPVerificationController(mobileNumber: mobileNo, nonce: response.nonce, isFbSignup: self!.isFbSignup, isNewUser: false, isverifyMethodOtp: false, referralCode: self?.referralCode ?? "") {
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }) { [weak self] (error) in
            self?.handleError(error)
        }
    }
    
    func signInWithFB(isForceLinkFb: Bool?, referralCode:String?) {
        
        self.view.endEditing(true)
        
        if isForceLinkFb == nil && self is LoginWelcomeViewController {
            SignInGAPManager.signinOrSignUpEvent(withEventType: .startedSignIn, withMethod: .facebook, withVerifyType: nil, withOtherDetails: ["from_page":"Welcome_Page"])
        }
        else if isForceLinkFb == nil && self is SignInWithPasswordViewController {
            SignInGAPManager.signinOrSignUpEvent(withEventType: .startedSignIn, withMethod: .facebook, withVerifyType: nil, withOtherDetails: ["from_page":"Login"])
        }
        
        var linkFBAccount : Bool? = isForceLinkFb
        
        func showDialogToUser(message: String?){
            
            AuthDepedencyInjector.uiDelegate?.showAlertActionPrompt(withTitle: "", msg: message ?? "Mobile No Already Exist", confirmTitle: "Create New Account", cancelTitle: "Link Account", onCancel: {
                linkFBAccount = true
                loginToFaceBookApiCall()
            }, onConfirm: {
                linkFBAccount = false
                self.isFbSignup = true
                loadMobileEntryScreen(with: nil)
            })
        }
        
        func loadMobileEntryScreen(with newMobile:String?){
            //<NITIN>
            /*let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let mobileVC = storyboard.instantiateViewController(withIdentifier: "MobileVerificationViewController") as! MobileVerificationViewController
            mobileVC.isFbSignup = true
            mobileVC.referralCode = self.referralCode
            
            if let mobileNumber = newMobile {
                mobileVC.mobileNo = mobileNumber
            }
            
            mobileVC.pushcontroller = self.pushcontroller
            self.navigationController?.pushViewController(mobileVC, animated: true);*/
        }
        
        func loginToFaceBookApiCall() {
            
            ActivityIndicator.show(on: self.view, withMessage: "verifying..") //URL_ACT_STYLE_FULL_SCREEN_BLUR
            
            AuthService.newSignInWithFacebook(linkFBAccount, referral: self.referralCode, success: { [weak self](data) in
                
                guard let strongSelf = self else { return }
                
                ActivityIndicator.hide(on: strongSelf.view)
                if let response = data as? OtpVerifiedData, response.isSuccess == true {
                    self?.isFbSignup = true
                    self?.userVerificationData = response
                    if response.userStatusType == .fbLinkDialog {
                        showDialogToUser(message: response.message)
                    }
                    else if response.userStatusType == .absent || response.userStatusType == .createAccountWithFBMobile || response.userStatusType == .createAccountWithNewMobile  {
                        if response.fbPhone != nil {
                            //call otp verify screen
                            if self?.mconnectData == nil {
                                self?.requestFBOTPWithMobileNo(response.fbPhone!)
                            } else {
                                self?.verifymConnectDataWithMobileNo(response.fbPhone!)
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
                            if self?.mconnectData == nil {
                                self?.requestFBOTPWithMobileNo(response.userData!.userInfo!.fbPhone!)
                            }
                            else{
                                self?.verifymConnectDataWithMobileNo(response.userData!.userInfo!.fbPhone!)
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
                        self?.userSuccessfullyLoggedIn()
                    }
                }
                else{
                    self?.handleError(nil)
                }
            }) { [weak self] (error) in
                
                ActivityIndicator.hide(on: self?.view)
                self?.handleError(error)
            }
        }
        
        
        ActivityIndicator.show(on: self.view, withMessage: "verifying..")
        if GoFacebookManager.shared.isFacebookSessionOpen {
            GoFacebookManager.shared.signOutFromFacebook()
        }
        
        GoFacebookManager.shared.loginToFacebook( completion: { [weak self] (success, error) in
            ActivityIndicator.hide(on: self?.view)
            if (success) {
                loginToFaceBookApiCall()
            }
            else if let _ = error {
                self?.handleError(error)
            }
            })
    }
    
    
    func verifymConnectDataWithMobileNo(_ mobileNo: String){
        self.view.endEditing(true)
        AuthService.verifyMobileWithMconnect(withMobile: mobileNo, mconnectData: self.mconnectData!, isFBSignUp: self.isFbSignup, referralCode: self.referralCode, success: { [weak self] (responseData) in
            self?.handleMConnectSuccessData(responseData, mobileNo:mobileNo)
        }) { [weak self](error) in
            self?.handleMConnectFailure(mobileNo: mobileNo)
        }
    }
    
    func handleMConnectSuccessData(_ responseData: Any?, mobileNo: String){
        //over ride this function to process
    }
    
    func handleMConnectFailure(mobileNo: String){
        //over ride this to call otp request in mconnect failure
    }
}
    
