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
}
