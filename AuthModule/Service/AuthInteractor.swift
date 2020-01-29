//
//  AuthInteractor.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import NetworkLayerFramework

typealias FailureBlock = (ErrorData?) -> Void
typealias SuccessBlock = (Any?) -> Void

class AuthService: AuthServiceProtocol {
    
    static func requestOTPforMobile(_ mobileNumber: String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        self.requestOTPService(mobileNumber, forceSendOtp: true, isResendOtp: false, success: success, failure: failure)
    }
    
    static func requestToResendOTPforMobile(_ mobileNumber: String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        self.requestOTPService(mobileNumber, forceSendOtp: true, isResendOtp: true, success: success, failure: failure)
    }

    static func checkAccountExistence(with mobileNumber:String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        self.requestOTPService(mobileNumber, forceSendOtp: false, isResendOtp: false, success: success, failure: failure)
    }
    
    static func requestFacebookOTPforMobile(_ mobileNumber: String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        self.verifyFBNumberApiWithMobileNumber(mobileNumber, forceSendOtp: true, isResendOtp: false, success: success, failure: failure)
    }
    
    static func requestFacebookToResendOTP(_ mobileNumber: String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        self.verifyFBNumberApiWithMobileNumber(mobileNumber, forceSendOtp: true, isResendOtp: true, success: success, failure: failure)
    }
    
    static func forgotPasswordRequest(withMobile mobileNumber:String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        
        var parameters = Dictionary<String, String>()
        parameters["mobile"] = mobileNumber
        
        Session.service.post(LoginConstants.forgotPasswordUrl(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            success(json.dictionaryObject)
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: json?.dictionaryObject ?? error))
        })
    }
    
    static func verifyReferralCode(referralCode:String, isBranchFlow:Bool, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        
        var parameters = Dictionary<String, String>()
        parameters[Keys.referralCode] = referralCode
        parameters["client_id"] = AuthNetworkUtils.getAuthKey()
        parameters["did"] = AuthNetworkUtils.getUUID()
        parameters["device_id"] = AuthNetworkUtils.getUUID()
        
        if isBranchFlow == true {
            parameters["device_id"] = "true"
        }
        
        Session.service.post(LoginConstants.verifyReferralCodeUrl(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            success(json.dictionaryObject)
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: json?.dictionaryObject ?? error))
        })
    }
    
    static func newSignInWithFacebook(_ isLinkFB:Bool?, referral:String?, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        var parameters = Dictionary<String, Any>()
        
        parameters[LoginConstants.kFBAccessToken] = AccessToken.current?.tokenString
        if isLinkFB == true {
            parameters["link_fb"] = "true"
        }
        if let referralCode = referral, !referralCode.isEmpty {
            parameters[Keys.referralCode] = referral
        }
        parameters["client_id"] = AuthNetworkUtils.getAuthKey()
        parameters["did"] = AuthNetworkUtils.getUUID()
        parameters["device_id"] = AuthNetworkUtils.getUUID()
        
        Session.service.post(LoginConstants.fbSignupAccountUrl(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            success(LoginOTPVerifyParser().parseJSON(json.dictionaryObject) as? OtpVerifiedData)
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: error))
        })
    }
    
    static func validateForMconnect(success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        Session.service.post(LoginConstants.mConnectGetDeviceDetailsUrl(), data: appendDefaultParameters(params: nil), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            success(MconnectDataParser().parseJSON(json.dictionaryObject))
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: error))
        })
    }
    
    private static func requestOTPService(_ mobileNumber: String, forceSendOtp: Bool, isResendOtp: Bool, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        var parameters = Dictionary<String, Any>()
        
        parameters["mobile"] = mobileNumber
        parameters["send_otp"] = forceSendOtp ? "true" : "false"
        parameters["otp_resend"] = isResendOtp ? "true" : "false"
        
        Session.service.post(LoginConstants.requestOTPUrl(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            success(json.dictionaryObject)
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: error))
        })
    }
    
    static func loginWithMobileAndPassword(_ mobileNo:String, referralCode:String, withPassword password:String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        
        var parameters = Dictionary<String, String>()
        
        parameters["mobile"] = mobileNo
        parameters["password"] = password
        if referralCode.isEmpty == false {
            parameters[Keys.referralCode] = referralCode
        }
        parameters["client_id"] = AuthNetworkUtils.getAuthKey()
        parameters["did"] = AuthNetworkUtils.getUUID()
        parameters["device_id"] = AuthNetworkUtils.getUUID()
        
        Session.service.post(LoginConstants.verifyOTPUrl(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            success(json.dictionaryObject)
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: json?.dictionaryObject ?? error))
        })
    }
    
    private static func verifyFBNumberApiWithMobileNumber(_ mobile: String, forceSendOtp: Bool, isResendOtp: Bool, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        
        var parameters = Dictionary<String, String>()

        parameters["mobile"] = mobile
        parameters["send_otp"] = forceSendOtp ? "true" : "false"
        parameters["otp_resend"] = isResendOtp ? "true" : "false"
        if AuthUtils.isEmptyString(AccessToken.current?.tokenString) == false {
            parameters[LoginConstants.kFBAccessToken] = AccessToken.current?.tokenString
        }
        
        Session.service.post(LoginConstants.requestOTPUrl(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            success(LoginMobileVerifyParser().parseJSON(json.dictionaryObject) as? MobileVerifiedData)
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: error))
        })
    }
    
    static func verifyOtp(_ mobileNo:String, withOtp otp:String, nonce:String, isFBSignup:Bool, referralCode:String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        
        var parameters = Dictionary<String, String>()
        
        parameters["mobile"] = mobileNo
        parameters["otp"] = otp
        parameters["nonce"] = nonce
        parameters["client_id"] = AuthNetworkUtils.getAuthKey()
        parameters["did"] = AuthNetworkUtils.getUUID()
        parameters["device_id"] = AuthNetworkUtils.getUUID()
        if referralCode.isEmpty == false {
            parameters[Keys.referralCode] = referralCode
        }
        
        if isFBSignup == true && AuthUtils.isEmptyString(AccessToken.current?.tokenString) == false {
            parameters[NetworkConstants.kFBAccessToken] = AccessToken.current?.tokenString
        } else if let accessToken = AuthCache.shared.getUserDefaltObject(forKey: Keys.accessToken)  as? String {
            parameters[NetworkConstants.kAccessToken] = accessToken
        }
        
        Session.service.post(LoginConstants.verifyOTPUrl(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            success(json.dictionaryObject)
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: error))
        })
    }
    
    static func goServiceLogout(_ type : LogoutType) {
        var getDic: [String: Any] = AuthDepedencyInjector.networkDelegate?.getFlavourDictionary() ?? [String: Any]()
        getDic["byuser"] = (type == LogoutType.user ? "true" : "false")
        getDic["userid"] = UserDataManager.shared.activeUser?.userid
        Session.service.get(LoginConstants.logoutUser(), header: [:], parameters: getDic, timeoutInterval: .default, success: { (json) in
            
        }) { (json, error) in
            
        }
    }
    
    static func requestLoginWithRefreshAccessToken(successBlock: (() -> Void)?, errorBlock: (() -> Void)?) {
        
        guard AuthCache.shared.getUserDefaltObject(forKey: Keys.refreshToken) != nil || UserDataManager.shared.isLoggedIn else { return }
        
        if APIRetryHandler.shared.canRetryAuthApi() {
            var parameters = [String: Any]()
            parameters[NetworkConstants.kFlavourKey] = NetworkConstants.kMajorFlavour
            parameters["versioncode"] = AuthDepedencyInjector.networkDelegate?.getAppVersion()
            parameters["client_id"] = AuthNetworkUtils.getAuthKey()
            parameters["grant_type"] = Keys.refreshToken
            parameters[Keys.refreshToken] = AuthCache.shared.getUserDefaltObject(forKey: Keys.refreshToken)
            
            let authBase64Part = "\(AuthNetworkUtils.getAuthKey()):\(AuthNetworkUtils.getAuthSecret())".toBase64()
            let auth = "Basic \(authBase64Part)"
            
            Session.service.get(LoginConstants.refreshTokenUrl(), header: ["goibibo-authorization": auth], parameters: parameters, timeoutInterval: .default, success: { (data) in
                
                if let jsonData = data.dictionaryObject {
                    
                    if let errMain = jsonData[Keys.error] as? String, errMain == "invalid_request" {
                        
                        if let refresh_token = AuthCache.shared.getUserDefaltObject(forKey: Keys.refreshToken) as? String, let parameterRefreshToken = parameters[Keys.refreshToken] as? String, refresh_token != parameterRefreshToken {
                            requestLoginWithRefreshAccessToken(successBlock: successBlock, errorBlock: errorBlock)
                        } else {
                            AuthAlert.show(message: "Your login session is expired.")
                            UserDataManager.shared.logout(type: .api)
                        }
                        
                    } else {
                        
                        AuthCache.shared.setUserDefaltObject(jsonData[Keys.accessToken], forKey: Keys.accessToken)
                        AuthCache.shared.setUserDefaltObject(jsonData[Keys.tokenType], forKey: Keys.tokenType)
                        AuthCache.shared.setUserDefaltObject(jsonData[Keys.expiresIn], forKey: Keys.expiresIn)
                        AuthCache.shared.setUserDefaltObject(jsonData[Keys.refreshToken], forKey: Keys.refreshToken)
                        AuthCache.shared.setUserDefaltObject(jsonData[Keys.firebaseToken], forKey: Keys.firebaseToken)
                        AuthCache.shared.setUserDefaltObject(jsonData[Keys.iplFirebaseToken], forKey: Keys.iplFirebaseToken)
                        AuthCache.shared.setUserDefaltObject(NSDate.init(timeInterval: (TimeInterval(jsonData[Keys.expiresIn] as! Int)), since: Date()), forKey: Keys.tokenExpiry)
                        AuthCache.shared.setUserDefaltObject(jsonData[Keys.firebaseToken], forKey: Keys.firebaseToken)
                        UserDataManager.shared.accessTokenUpdated()
                        UserDataManager.updateLoggedInUserGoCash()
                        
                        if(successBlock != nil) {
                            successBlock!()
                        }
                    }
                }
                
            }) { (json, error) in
                if let error = error as NSError?, error.code == 400 {
                    let refreshToken = AuthCache.shared.getUserDefaltObject(forKey: Keys.refreshToken) as? String
                    if let parameterRefreshToken = parameters[Keys.refreshToken] as? String, !parameterRefreshToken.isEmpty ,refreshToken != parameterRefreshToken {
                        
                        requestLoginWithRefreshAccessToken(successBlock: successBlock, errorBlock: errorBlock)
                    } else {
                        if UserDataManager.shared.isLoggedIn {
                            AuthAlert.show(message: "Your login session is expired.")
                            UserDataManager.shared.logout(type: .api)
                        } else {
                            if errorBlock != nil {
                                errorBlock!()
                            }
                        }
                    }
                }
            }
        } else {
            
            if UserDataManager.shared.isLoggedIn {
                AuthAlert.show(message: "Your login session is expired.")
                UserDataManager.shared.logout(type: .api)
            } else {
                if errorBlock != nil {
                    errorBlock!()
                }
            }
        }
    }

    static func requestToLoginWithWhatsApp(_ whatsAppToken:String, referralCode:String?, extraKey: String?, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        var parameters = Dictionary<String, Any>()
        parameters["whatsapp_access_token"] = whatsAppToken
        parameters["flavour"] = "ios"
        parameters["client_id"] = AuthNetworkUtils.getAuthKey()
        parameters["did"] = AuthNetworkUtils.getUUID()
        parameters["extra_keys"] = extraKey
        if let rcode =  referralCode {
            parameters[Keys.referralCode] = rcode
        }
        
        Session.service.post(LoginConstants.whatsappLoginURL(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            success(LoginOTPVerifyParser().parseJSON(json.dictionaryObject) as? OtpVerifiedData)
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: error))
        })
    }
    
    static func verifyMobileWithMconnect(withMobile mobileNo:String, mconnectData:MconnectData, isFBSignUp:Bool, referralCode:String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        
        var dict: Dictionary<String,String> = ["o":mconnectData.operatorName!,"m": mobileNo,"c":AuthNetworkUtils.getAuthKey()]
        dict["d"] = AuthNetworkUtils.getUUID()
            
        if isFBSignUp == true && AuthUtils.isEmptyString(AccessToken.current?.tokenString) == false {
            dict["f"] = AccessToken.current?.tokenString ?? ""
        }
        else{
            if let accessToken = AuthCache.shared.getUserDefaltObject(forKey: Keys.accessToken)  as? String {
                dict["a"] = accessToken
            }
        }
        if referralCode.isEmpty == false {
            dict["r"] = referralCode
        }
        
        if let xData = mconnectData.xData {
             dict["xdata"] = xData
        }
        
        var strToRsa = ""
        if let theJSONData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            strToRsa = String(data: theJSONData, encoding: .ascii) ?? ""
            print("JSON string = \(strToRsa)")
        }
        
        let encryptedKey = RSA.encryptString(strToRsa, publicKey: mconnectData.mConnectPublicKey)
        
        let plainData = encryptedKey!.data(using: .utf8)
        let base64String = plainData?.base64EncodedString()
        let state = "&state=" + base64String!
        let loginHint = "&login_hint=" + "MSISDN:91" + mobileNo
        let strToHash = mobileNo + "|" + NetworkConstants.nonceSalt
        let hashedStr = "&nonce=" + CommonUtils.md5Hash(strToHash)
        
        var urlStr = mconnectData.authUrl!
        urlStr += state + loginHint + hashedStr
        
        Session.service.get(urlStr, success: { (json) in
            success(MconnectVerifiedDataParser().parseJSON(json.dictionaryObject))
        }) { (json, error) in
            failure(nil)
        }
    }

}
