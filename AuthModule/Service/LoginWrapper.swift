//
//  LoginWrapper.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class LoginWrapper {

    static func hashAuthString(for params: Dictionary<String, Any>) -> String {
        return hashAuthString(ForDictionary: params, withSalt: AuthNetworkUtils.syncMD())
    }
    
    private static func hashAuthString(ForDictionary dictionary: Dictionary<String, Any>, withSalt salt: String) -> String {
        let sortedKeys = dictionary.keys.sorted()
        var hash1 = sortedKeys.reduce("") { $0 + "\(dictionary[$1]!)|" }
        hash1 = hash1 + salt
        return CommonUtils.md5Hash(hash1)
    }
    
    static func handleLoginData(_ dictionary: [String: Any]) {
        if let errMain = dictionary["error"] as? String, let errDesc = dictionary["error_description"] as? String {
            //IBSVAnalytics.logConnFinError(LOG_SERVICE_OAUTH_USER_DATA, category: LOG_LOGIN_USER, event: "\(errMain) : \(errDesc)", error: nil)
            //Utils.showAlert("\(errMain) : \(errDesc)")
            return
        }
        
        let isSuccessful:Bool = dictionary["success"] as? Bool ?? false
        
        if (!isSuccessful) {
            var errorResponse: Any?
            if let dict = dictionary["Error"] as? [String: Any], let response = dict["non_field_errors"] {
                errorResponse = response
            }
            if let errorResponseArray = errorResponse as? [String], !errorResponseArray.isEmpty {
                //IBSVAnalytics.logConnFinError(LOG_SERVICE_OAUTH_USER_DATA, category: LOG_LOGIN_USER, event: errorResponseArray.first, error: nil)
                //Utils.showAlert(errorResponseArray.first)
            } else if let errorResponse = errorResponse as? String {
                //IBSVAnalytics.logConnFinError(LOG_SERVICE_OAUTH_USER_DATA, category: LOG_LOGIN_USER, event: errorResponse, error: nil)
                //Utils.showAlert(errorResponse)
            }
        }
        
        guard dictionary["success"] as? Bool == true, let data = dictionary as? [String: Any] else {
            return
        }
        
        if let awsDetails = data["aws_details"] as? String, AuthUtils.isValidString(awsDetails) {
            AuthUtils.setNormalAmazonSecureCredential(awsDetails)
        }
        
        if let awsDetails2 = data["aws_details_2"] as? String, AuthUtils.isValidString(awsDetails2) {
            AuthUtils.setChanakyaAmazonSecureCredential(awsDetails2)
        }
        
        var jsonData = [String: Any]()
        
        if data.keys.contains("data") {
            jsonData = data["data"] as? [String: Any] ?? [:]
        }
        
        if let tokenData = jsonData["token_details"] as? Dictionary<String, Any> {
            AuthCache.shared.setUserDefaltObject(tokenData["access_token"], forKey: "access_token")
            AuthCache.shared.setUserDefaltObject(tokenData["token_type"], forKey: "token_type")
            AuthCache.shared.setUserDefaltObject(tokenData["expires_in"], forKey: "expires_in")
            AuthCache.shared.setUserDefaltObject(tokenData["refresh_token"], forKey: "refresh_token")
            AuthCache.shared.setUserDefaltObject(tokenData["firebase_token"], forKey: "firebase_token")
            AuthCache.shared.setUserDefaltObject(tokenData["ipl_firebase_token"], forKey: "ipl_firebase_token")
            AuthCache.shared.setUserDefaltObject(NSDate.init(timeInterval: (TimeInterval(tokenData["expires_in"] as! Int)), since: Date()), forKey: "token_expiry")
            AuthCache.shared.setUserDefaltObject(tokenData["firebase_token"], forKey: "firebase_token")
        }
        
        var dict = Dictionary<String, Any>()
        if let userInfo = jsonData["user_info"] as? Dictionary<String, Any> {
            dict = userInfo
            
            if let businessInfo = jsonData["business_info"] as? Dictionary<String, Any> {
                dict["business_info"] = businessInfo
            }
            
            if let referralDetails = jsonData["referral_details"] as? Dictionary<String, Any> {

                if !AuthUtils.isEmptyString(referralDetails["user_code"]) {
                    dict["user_code"] = referralDetails["user_code"]
                }
                
                if !AuthUtils.isEmptyString(referralDetails["branch_link"]) {
                    dict["branch_link"] = referralDetails["branch_link"]
                }
            }
            UserDataManager.shared.updateLoggedInUser(to: dict)
        }
        
        
        if let _ = jsonData["token_details"] as? Dictionary<String, Any> {
            UserDataManager.shared.accessTokenUpdated()
        }
        
        UserDataManager.updateLoggedInUserGoCash()
        
        if UserDataManager.shared.isWAChecked {
            WhatsAppManager.shared.setWhatsappOptInStatusPostLogin(status: true)
            
        }
        //<NITIN>
        //ConversionTrackingUtils.conversionTracking(for: kConversionTrackingForLogin)
        //IBSVAnalytics.logConnFinSuccess(LOG_SERVICE_OAUTH_USER_DATA, category: LOG_LOGIN_USER)
    }
    
}
