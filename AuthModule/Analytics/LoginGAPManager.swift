//
//  LoginGAPManager.swift
//  AuthModule
//
//  Created by Nitin Chadha on 05/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation

class SignInGAPManager: NSObject {
    
    static var IBSVAnalytics = AuthDepedencyInjector.AnalyticsDelegate
    static var FirebaseAnalytics = AuthDepedencyInjector.firebaseRemoteHandlerDelegate
    
    static let screenNameKey = "screenName"
    static var startTimer: DispatchTime?
    
    enum SigninScreenType: String {
        case welcome, enterOTP, createAccount, linkAccount, login, enterPassword, verifyPhone, secureAccount, enterPasswordOrOTP
    }
    
    enum SkipEventType: String {
        
        case loginSKip = "Login_Skipped"
        case skipDialog = "Skip_Dialog"
    }
    
    enum SignInEventType: String {
        case startedSignIn  = "Started_SignIn"
        case signIn = "Signed_in"
        case signUp = "Signed_up"
    }
    
    enum SignInMethodType: String {
        case email = "email"
        case facebook = "fb"
        case phone = "phone"
        case whatsApp = "Whatsapp"
        case keyChain = "keyChain"
    }
    
    enum VerifyMethod: String {
        case otp = "otp"
        case mconnect = "mconnect"
        case password = "password"
        case facebook = "facebook"
        case whatsapp = "Whatsapp"
        case keyChain = "keyChain"
    }
    
    
    //MARK: Public Methods
    static func logOpenScreenEvent(for screenType: SigninScreenType, otherParams details:Dictionary<String,Any>?) {
        
        let openScreenEventName = "Onboarding"
        let screenName = getScreenName(for: screenType)
        var attributes: Dictionary<String,Any> = [screenNameKey:screenName]
        if let dict = details {
            attributes = attributes.merge(dict)
            IBSVAnalytics?.logCategory(event: getScreenName(for: screenType), dictionary: dict)
        }
        else{
            IBSVAnalytics?.logCategory(event: getScreenName(for: screenType), dictionary: nil)
        }
        
        
        
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: "openScreen", withAttributes:attributes)
        
        var tempAttributes = details
        tempAttributes?["Action"] = "screenLoad"
        tempAttributes?["screenName"] = screenName
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: openScreenEventName, withAttributes:tempAttributes)
    }
    
    static func logOpenScreenEventWithExplictEventName(for eventName:String, screenType: SigninScreenType, otherParams details:Dictionary<String,Any>?) {
        let openScreenEventName =  eventName
        let screenName = getScreenName(for: screenType)
        var attributes: Dictionary<String,Any> = [screenNameKey:screenName]
        if let dict = details {
            attributes = attributes.merge(dict)
            IBSVAnalytics?.logCategory(event: getScreenName(for: screenType), dictionary: dict)
        }
        else{
            IBSVAnalytics?.logCategory(event: getScreenName(for: screenType), dictionary: nil)
        }
        
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: "openScreen", withAttributes:attributes)
        
        var tempAttributes = details
        tempAttributes?["Action"] = "screenLoad"
        tempAttributes?["screenName"] = screenName
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: openScreenEventName, withAttributes:tempAttributes)
    }
    
    static func logClickEvent(for screenType: SigninScreenType, otherParams details:Dictionary<String,Any>?) {
        let screenName = getScreenName(for: screenType)
        var tempAttributes = details
        tempAttributes?["Action"] = "clickEvent"
        tempAttributes?["screenName"] = screenName
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: "Onboarding", withAttributes:tempAttributes)
    }
    
    static func logGenericEvent(for screenType: SigninScreenType, action:String, otherParams details:Dictionary<String,Any>?) {
        let screenName = getScreenName(for: screenType)
        var tempAttributes = details
        tempAttributes?["Action"] = action
        tempAttributes?["screenName"] = screenName
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: "Onboarding", withAttributes:tempAttributes)
    }
    
    static func logGenericEventWithoutScreen(for action:String,otherParams details:Dictionary<String,Any>?) {
        var tempAttributes = details
        tempAttributes?["Action"] = action
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: "Onboarding", withAttributes:tempAttributes)
    }
    
    static func logGenericEventWithExplictEventNameWithoutScreen(for eventName:String, action:String, otherParams details:Dictionary<String,Any>?) {
       var tempAttributes = details
        tempAttributes?["Action"] = action
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: eventName, withAttributes:tempAttributes)
    }
    
    
    static func startTime() {
        startTimer = DispatchTime.now()
    }
    
    static func getTimeInterval() -> Double {
        let endTime = DispatchTime.now()
        let nanoTime = endTime.uptimeNanoseconds - (startTimer?.uptimeNanoseconds ?? 0)
        let timeInterval = Double(nanoTime) / 1_000_000_000
        
        return timeInterval
    }
    
    static func skipButtonTapped(with type: SkipEventType, withOtherDetails details: Dictionary<String,Any>?) {
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: type.rawValue, withAttributes:details)
        IBSVAnalytics?.logCategory(event: type.rawValue, dictionary: details)
    }
    
    static func signinOrSignUpEvent(withEventType eventType:SignInEventType, withMethod methodType:SignInMethodType?, withVerifyType verifyType:VerifyMethod?,withOtherDetails details: Dictionary<String,Any>?) {
        
        var attributes: Dictionary<String, Any> = [:]
        if methodType != nil && eventType == .signIn{
            attributes["signed_in_type"] = methodType!.rawValue
        }
        else if methodType != nil && eventType == .signUp{
            attributes["signup_type"] = methodType!.rawValue
        }
        else if methodType != nil && eventType == .startedSignIn{
            attributes["started_signin_type"] = methodType!.rawValue
        }
        
        if verifyType != nil {
            attributes["phone_verify_method"] = verifyType!.rawValue
        }
        if details != nil {
            attributes = attributes.merge(details!)
        }
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: eventType.rawValue, withAttributes: attributes)
        IBSVAnalytics?.logCategory(event: eventType.rawValue, dictionary: attributes)
    }
    
    //    static func signInOrSignUpEvent(_ isExistingUser:Bool, withOtherDetails details: Dictionary<String,Any>?){
    //
    //        if isExistingUser {
    //            //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: "Signed_in", withAttributes:details)
    //        }
    //        else{
    //            //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: "Signed_up", withAttributes:details)
    //        }
    //    }
    
    static func signInTappedEvent(with eventName: String, withOtherDetails details: Dictionary<String,Any>?){
        
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: eventName, withAttributes:details)
        IBSVAnalytics?.logCategory(event: eventName, dictionary: details)
    }
    
    
    //MARK: Private Function
    
    private static func getScreenName(for screenType: SigninScreenType) -> String{
        
        var screenName = ""
        
        switch screenType {
        case .welcome:
            screenName = "login_signup_start"
            
        case .enterOTP:
            screenName = "verify_otp"
            
        case .createAccount:
            screenName = "signup_add_profile_details"
            
        case .linkAccount:
            screenName = "Link_Existing_Account"
            
        case .login:
            screenName = "Login"
            
        case .enterPassword:
            screenName = "verify_password"
            
        case .verifyPhone:
            screenName = "Verify_Phone_Number"
            
        case .secureAccount:
            screenName = "Secure_Account"
            
        case .enterPasswordOrOTP:
            screenName = "verify_password"
        }
        
        return screenName
    }
    
}



class LoginGAPManager: NSObject {
    
    static let screenNameKey = "screenName"
    static var IBSVAnalytics = AuthDepedencyInjector.AnalyticsDelegate
    
    enum LoginTapType: String {
        
        case signInContinue = "Continue"
        case resendOTP = "Send_Code_Again"
        case signIn = "Sign_in"
        case requestOTP = "Request_OTP"
        case createAccount = "Create_Account"
        case fbSignup = "Facebook_SignUp"
        case fbSignin = "Facebook_SignIn"
        case skipForNow = "Skip_For_Now"
        case forgotPassword = "Forgot_Password"
    }
    enum SkipTapType: String {
        
        case skipScreen = "Back_Pressed"
        case backScreen = "Skip_For_Now"
    }
    
    
    
    enum LoginMethodType: String {
        
        case otp = "OTP"
        case password = "Password"
        case mConnect = "MConnect"
        case legacyLogin = "Legacy_Login"
    }
    
    enum LoginUserType: String {
        
        case goibiboUser = "goibibo_login"
        case fbUser = "facebook_login"
        case mobileUser = "mobile_login"
    }
    
    //MARK: Public Methods
    static func logOpenScreenEvent(for controller: LoginBaseViewController) {
        
        let openScreenEventName = "openScreen"
        let attributes = ["cdCatQuery": "Social", screenNameKey: getCurrentScreenName(for: controller)]
        
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: openScreenEventName, withAttributes:attributes)
    }
    
    static func logTappedEvent(with type: LoginTapType, forController controller:LoginBaseViewController) {
        
        let tapTypeKeyName = "buttonTapType"
        let tapValueKeyName = "buttonTapValue"
        let tapEventName = "onboardingTapClick"
        var attributes: Dictionary<String, Any> = ["mConnectCalled": false]// Need to check mConnect
        
        attributes[screenNameKey] = getCurrentScreenName(for: controller)
        attributes[tapTypeKeyName] = getCurrentScreenName(for: controller)
        attributes[tapValueKeyName] = type.rawValue
        
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: tapEventName, withAttributes:attributes)
    }
    
    static func skipButtonTapped(with type: SkipTapType, forController controller:LoginBaseViewController) {
        
        let skipTypeKeyName = "skipType"
        let tapEventName = "onboardingSkipFlow"
        var attributes: Dictionary<String, Any> = ["mConnectCalled": false]// Need to check mConnect
        if UserDataManager.shared.isLoggedIn {
            attributes["loginStatus"] = "true"
        }
        attributes[screenNameKey] = getCurrentScreenName(for: controller)
        attributes[skipTypeKeyName] = type.rawValue
        
        
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: tapEventName, withAttributes:attributes)
    }
    
    
    static func logLoginSuccessEvent(with loginMethodType: LoginMethodType, isExistingUser: Bool, userType: LoginUserType, forController controller:LoginBaseViewController) {
        
        let successEventName = "onboardingSuccess"
        let loginMethodKeyName = "loginMethod"
        let existingUserKeyName = "existingUser"
        let userTypeKeyName = "accountType"
        
        var attributes: Dictionary<String, Any> = [:]
        
        attributes[screenNameKey] = getCurrentScreenName(for: controller)
        attributes[loginMethodKeyName] = loginMethodType.rawValue
        attributes[existingUserKeyName] = isExistingUser ? "true" : "false"
        attributes[userTypeKeyName] = userType.rawValue
        
        //FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: successEventName, withAttributes:attributes)
        IBSVAnalytics?.logCategory(event: (isExistingUser ? "Signin Success" : "Signup Success"), dictionary: attributes)
    }
    
    
    //MARK: Private Methods
    private static func getCurrentScreenName(for controller: LoginBaseViewController) -> String {
        
        let loginScreenName = "Welcome"
        let otpScreenName = "Enter_OTP"
        let createAccountOrExistingScreenName = "Create_Account"
        let userConfirm = "I_want_goCash_Plus_Page"
        var screenName = ""
        
        if let _ = controller as? LoginWelcomeViewController {
            screenName = loginScreenName
        }
        /*<NITIN>else if let _ = controller as? OtpVerificationViewController {
            screenName = otpScreenName
        }
        else if let _ = controller as? UserSignupViewController {
            screenName = createAccountOrExistingScreenName
        }
        else if let _ = controller as? UserConfirmationViewController {
            screenName = userConfirm
        }*/
        return screenName
    }
    
}
