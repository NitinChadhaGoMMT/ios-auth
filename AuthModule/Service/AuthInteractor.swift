//
//  AuthInteractor.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation
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
    
    static func verifyReferralCode(referralCode:String, isBranchFlow:Bool, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        
        var parameters = Dictionary<String, String>()
        parameters["referral_code"] = referralCode
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
    
    static func validateForMconnect(success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        Session.service.post(LoginConstants.mConnectGetDeviceDetailsUrl(), data: appendDefaultParameters(params: nil), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            success(json.dictionaryObject)
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
            parameters["referral_code"] = referralCode
        }
        parameters["client_id"] = AuthNetworkUtils.getAuthKey()
        parameters["did"] = AuthNetworkUtils.getUUID()
        parameters["device_id"] = AuthNetworkUtils.getUUID()
        
        Session.service.post(LoginConstants.verifyOTPUrl(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            //success(LoginOTPVerifyParser().parseJSON(json.dictionaryObject) as? OtpVerifiedData)
            success(json.dictionaryObject)
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: json?.dictionaryObject ?? error))
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
            parameters["referral_code"] = referralCode
        }
        
        if isFBSignup == true && AuthCache.shared.facebookToken.isEmpty == false {
            parameters[AuthNetworkConstants.kFBAccessToken] = AuthCache.shared.facebookToken
        } else if let accessToken = AuthCache.shared.getUserDefaltObject(forKey: "access_token")  as? String {
            parameters[AuthNetworkConstants.kAccessToken] = accessToken
        }
        
        Session.service.post(LoginConstants.verifyOTPUrl(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { (json) in
            //success(LoginOTPVerifyParser().parseJSON(json.dictionaryObject) as? OtpVerifiedData)
            success(json.dictionaryObject)
        }, failure: { (json, error) in
            failure(getErrorDataFrom(error: error))
        })
    }
    
    static func verifyMobileWithMconnect(withMobile mobileNo:String, mconnectData:MconnectData, isFBSignUp:Bool, referralCode:String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        
        var dict: Dictionary<String,String> = ["o":mconnectData.operatorName!,"m": mobileNo,"c":AuthNetworkUtils.getAuthKey()]
        dict["d"] = AuthNetworkUtils.getUUID()

        //<NITIN>
        if false {
        //if isFBSignUp == true && AuthUtils.isEmptyString(AccessToken.current?.tokenString) == false {
            dict["f"] = ""//<NITIN>AccessToken.current?.tokenString ?? ""
        }
        else{
            if let accessToken = AuthCache.shared.getUserDefaltObject(forKey: "access_token")  as? String {
                dict["a"] = accessToken
            }
        }
        if referralCode.isEmpty == false {
            dict["r"] = referralCode
        }
        
        if let xData = mconnectData.xData {
             dict["xdata"] = xData
        }
        
        //<NITIN>
        //let writer = SBJsonWriter()
        //let strToRsa = writer.string(with: dict)

        //let encryptedKey = RSA.encryptString(strToRsa, publicKey:mconnectData.mConnectPublicKey)
        var encryptedKey: String?
        encryptedKey = ""
        let plainData = encryptedKey!.data(using: .utf8)
        let base64String = plainData?.base64EncodedString()
        let state = "&state=" + base64String!
        let loginHint = "&login_hint=" + "MSISDN:91" + mobileNo
        let strToHash = mobileNo + "|" + AuthNetworkConstants.nonceSalt
        let hashedStr = "&nonce=" + CommonUtils.md5Hash(strToHash)
        
        var urlStr = mconnectData.authUrl!
        urlStr += state + loginHint + hashedStr
        
        Session.service.get(urlStr, success: { (json) in
            
        }) { (json, error) in
            
        }
        
    }
}
