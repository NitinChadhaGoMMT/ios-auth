//
//  AuthBaseService.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation

protocol AuthServiceProtocol {
    
    static func appendDefaultParameters(params: Dictionary<String, Any>?) -> Dictionary<String, Any>
    
    static func getErrorDataFrom(error: Any?) -> ErrorData?

}

extension AuthServiceProtocol {
    
    static func appendDefaultParameters(params: Dictionary<String, Any>?) -> Dictionary<String, Any> {
        var parameters = Dictionary<String, Any>()
        
        if let _ = params {
            parameters = parameters.merge(params!)
        }
        
        parameters[AuthNetworkConstants.kFlavourKey] = AuthNetworkConstants.kMajorFlavour
        parameters[AuthNetworkConstants.kHashKey] = LoginWrapper.hashAuthString(for: parameters) as Any?
        return parameters
    }
    
    static func getErrorDataFrom(error: Any?) -> ErrorData? {
        let errorData = ErrorData()
        
        guard let responseObject = error as? [String: Any] else {
            errorData.nonFieldErrorMsg = "Something went wrong, please try again after sometime."
            return errorData
        }
        
        var errorObject = [String: Any]()
        if let data = responseObject["error"] as? Dictionary<String, Any> {
            errorObject = data
        } else if let data = responseObject["errors"] as? Dictionary<String, Any> {
            errorObject = data
        }
        
        let errorMsg = errorObject["non_field_errors"] as? String
        if(errorMsg != nil){
            errorData.nonFieldErrorMsg = errorMsg
            return errorData
        }
        
        let fieldErrMsg = errorObject["field_errors"] as? Dictionary<String,Any>
        if(fieldErrMsg != nil){
            errorData.errorMsgString = fieldErrMsg!["fb_access_token"] as? String
            
            if AuthUtils.isEmptyString(errorData.referalErrorMsg) {
                errorData.fieldErrorKey = "referral_code"
                errorData.referalErrorMsg = fieldErrMsg!["referral_code"] as? String
            }
            if AuthUtils.isEmptyString(errorData.errorMsgString) {
                errorData.fieldErrorKey = "fullname"
                errorData.errorMsgString = fieldErrMsg!["fullname"] as? String
            }
            if AuthUtils.isEmptyString(errorData.errorMsgString) {
                errorData.fieldErrorKey = "mobile_key"
                errorData.errorMsgString = fieldErrMsg!["mobile_key"] as? String
            }
            if AuthUtils.isEmptyString(errorData.errorMsgString) {
                errorData.fieldErrorKey = "email"
                errorData.errorMsgString = fieldErrMsg!["email"] as? String
            }
            if AuthUtils.isEmptyString(errorData.errorMsgString) {
                errorData.fieldErrorKey = "did"
                errorData.errorMsgString = fieldErrMsg!["did"] as? String
            }
            
            if AuthUtils.isEmptyString(errorData.errorMsgString) {
                if fieldErrMsg?.keys.first != nil {
                    errorData.errorMsgString = fieldErrMsg![fieldErrMsg!.keys.first!] as? String
                }
            }
            
            return errorData
        }
        
        errorData.errorMsgString = "Something went wrong, please try again after sometime."
        return errorData
    }
}
