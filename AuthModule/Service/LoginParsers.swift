//
//  LoginParsers.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

import UIKit

class LoginParser: NSObject {

    func parseJSON(_ json: Any?) -> Any?  {
        return json;
    }
    
    func getErrorDataFrom(error:Any?) -> ErrorData? {
        
        let errorData = ErrorData()
        guard let errorObject = error as? Dictionary<String, Any> else {
            errorData.nonFieldErrorMsg = "Something wrong . Please try after some time."
            return errorData
        }
        
        let errorMsg = errorObject["non_field_errors"] as? String
        if(errorMsg != nil){
            errorData.nonFieldErrorMsg = errorMsg
            return errorData
        }
        
        let fieldErrMsg = errorObject["field_errors"] as? Dictionary<String,Any>
        if(fieldErrMsg != nil){
            errorData.fbAccessTknMsg = fieldErrMsg!["fb_access_token"] as? String
            errorData.referalErrorMsg = fieldErrMsg![Keys.referralCode] as? String
            errorData.userNameErrorMsg = fieldErrMsg!["fullname"] as? String
            errorData.errorMsgString = fieldErrMsg!["email"] as? String
            if errorData.errorMsgString == nil {
                errorData.errorMsgString = fieldErrMsg!["mobile"] as? String
            }
            
            return errorData
        }
        
        return nil
    }
}


class LoginMobileVerifyParser: LoginParser {
  
   override func parseJSON(_ json: Any?) -> Any?  {
    
    guard let response = json as? Dictionary<String, Any> else {
        return nil;
    }
    
    let verifiedData = MobileVerifiedData()
    
    verifiedData.isSuccess = response["success"] as! Bool
    
    // Error Data
    if verifiedData.isSuccess == false {
        return nil;
    }
   // verifiedData.isNewUser = json?["new_user"] as! Bool
    verifiedData.nonce = response["nonce"] as? String
    verifiedData.message = response["message"] as? String
    
    if let existingUser = response["existing_user"] as? Bool {
       verifiedData.isExistingUser = existingUser
    }
    if let verifiedUser = response["is_verified"] as? Bool {
        verifiedData.isVerifiedUser = verifiedUser
    }
    if let sendOtp = response["send_otp"] as? Bool {
        verifiedData.isSendOtp = sendOtp
    }
        return verifiedData;
  }
    
}

class LoginVerifyReferralParser: LoginParser {
    override func parseJSON(_ json: Any?) -> Any?  {
        guard let response = json as? Dictionary<String, Any> else {
            return nil;
        }
        let verifiedData = ReferralVerifyData()
        
        verifiedData.isSuccess = response["success"] as! Bool
        
        // Error Data
        if verifiedData.isSuccess == false {
            return nil;
        }
        verifiedData.message = response["message"] as? String
        verifiedData.email = response["email"] as? String
        
        return verifiedData;
    }
}

class LoginReverseSyncContactProfiles: LoginParser {
    override func parseJSON(_ json: Any?) -> Any?  {
        guard let response = json as? Dictionary<String, Any> else {
            return nil;
        }
        
        guard let responseData = response["response"] as? Array<Dictionary<String, Any>> else {
            return nil;
        }
        
        let profileData = ReverseProfileData()
        
        if let success = response["success"] as? Bool {
            profileData.isSuccess = success
        }
        
        if let count = response["total_count"] as? Int {
            profileData.totalItems = count
        }
        else if let count = response["total_count"] as? String {
            profileData.totalItems = Int(count)!
        }
        
        var itemList = Array<ProfileData>()
        for item in responseData {
            let dataItem = ProfileData()
            dataItem.fname = item["firstname"] as? String
            dataItem.lname = item["lastname"] as? String
            dataItem.userid = item["userid"] as? String
            dataItem.phone = item["phone"] as? String
            dataItem.email = item["email"] as? String
            dataItem.title = item["title"] as? String
            dataItem.imgURL = item["img"] as? String
            
            itemList.append(dataItem)
        }
        profileData.profileItems = itemList
        
        return profileData;
    }
}


