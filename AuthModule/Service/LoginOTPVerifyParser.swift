//
//  LoginOTPVerifyParser.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

enum UserStatusType {
    case none, loggedIn, absent, fbLinkDialog, createAccountWithFBMobile, createAccountWithNewMobile,  verified, mixed, facebook, native
}

class LoginOTPVerifyParser: LoginParser {
    
    override func parseJSON(_ json: Any?) -> Any?  {
        
        guard let response = json as? Dictionary<String, Any> else {
            
            return nil;
        }
        
        let verifiedData = OtpVerifiedData()
        
        if let isSuccess = response["success"] as? Bool {
            verifiedData.isSuccess = isSuccess
        }
     
        // Error Data
        if verifiedData.isSuccess == false {
            return nil;
        }
        
        LoginWrapper.handleLoginData(response)

        verifiedData.mobileKey = response["mobile_key"] as? String
        verifiedData.message = response["msg"] as? String
        if AuthUtils.isEmptyString(verifiedData.message) {
         verifiedData.message = response["message"] as? String
        }
        
        verifiedData.detailMessage = response["detailMsg"] as? String
        verifiedData.userName = response["firstname"] as? String
       // let dict = response["user_status"] as! Dictionary<String, Any>
        verifiedData.userStatus = response["status"] as? String
        if verifiedData.userStatus == nil {
            verifiedData.userStatus = response["user_status"] as? String
        }
        if let existingUser = response["existing_user"] as? Int {
            verifiedData.isExistingUser = Bool(truncating: existingUser as NSNumber)
        }
        else if let existingUser = response["existing_user"] as? Bool {
            verifiedData.isExistingUser = existingUser
        }
        verifiedData.fbPhone = response["mobile_from_fb"] as? String
        verifiedData.facebookId = response["facebook_id"] as? String
        verifiedData.userStatusType = getUserStatusType(from: verifiedData.userStatus)
        
        if verifiedData.mobileKey != nil {
            //<NITIN>Utils.setMobileKey(verifiedData.mobileKey!)
        }
        
        if let mobile = response["mobile"] as? String {
            verifiedData.newMobile = mobile
        }
        
        verifiedData.userData = self.getLoggedInUserDataFrom(response["data"])
        
        return verifiedData;
    }
    
    func getUserStatusType(from text: String?) -> UserStatusType {
        
        if text == "USER_LOGGED_IN" {
            return .loggedIn
        }
        else if text == "MOBILE_VERIFIED" {
            return .verified
        }
        else if text == "MOBILE_FB" {
            return .facebook
        }
        else if text == "MOBILE_MIXED" {
            return .mixed
        }
        else if text == "MOBILE_NATIVE" {
            return .native
        }
        else if text == "MOBILE_ABSENT" {
            return .absent
        }
        else if text == "CREATE_ACCOUNT_WITH_MOBILE_FROM_FB" {
            return .createAccountWithFBMobile
        }
        else if text == "CREATE_ACCOUNT_WITH_NEW_MOBILE" {
            return .createAccountWithNewMobile
        }
        else if text == "FB_LINK" {
            return .fbLinkDialog
        }
        else {
            return .none
        }
    }
 
    // Get LooggedinUser Data
    func getLoggedInUserDataFrom(_ userObject: Any?) -> LoggedInUserData? {
 
        guard let userData = userObject as? Dictionary<String, Any> else {
            return nil
        }
        
        let loggedInData = LoggedInUserData()
        
        loggedInData.referalDetails = self.getReferalDataFrom(userData["referral_details"])
        loggedInData.ugcData = getUgcDataFrom(userData["ugc_data"])
        loggedInData.userInfo = getUserInfoFrom(userData["user_info"])
        loggedInData.tokenDetails = getTokenDataFrom(userData["token_details"])
        loggedInData.referralBonus = getReferralBonusDataFrom(userData["referral_bonus"])
        
        return loggedInData
    }
    
    // Get Referal Data
    func getReferalDataFrom(_ referalObject: Any?) -> ReferalDetails? {
        
        guard let referalData = referalObject as? Dictionary<String, Any> else {
            return nil
        }
        
        let referalDetails = ReferalDetails()
        referalDetails.referEarnUrl = referalData["refer_earn_url"] as? String
        referalDetails.twitterMsg = referalData["twitter"] as? String
        referalDetails.emailBodyData = referalData["email_body"] as? String
        referalDetails.downloadLaunchMsg = referalData["app_download_launch_msg"] as? String
        referalDetails.branchLink = referalData["branch_link"] as? String
        referalDetails.userCode = referalData["user_code"] as? String
        referalDetails.downloadReferMsg = referalData["app_download_refer_msg"] as? String
        referalDetails.facebookLink = referalData["facebook"] as? String
        referalDetails.socialMsg = referalData["social"] as? String
        referalDetails.emailSubject = referalData["email_subject"] as? String
        referalDetails.whatsAppMsg = referalData["whatsapp"] as? String
        
        return referalDetails
    }
    
    func getReferralBonusDataFrom(_ referralBonus: Any?) -> ReferralBonus? {
    
        guard let referalData = referralBonus as? Dictionary<String, Any> else {
            return nil
        }
        
        let bonusObject = ReferralBonus()
        
        if let earned = referalData["gocash_earned"] as? Int {
            bonusObject.goCashEarned =  earned
        }
        
        bonusObject.code = referalData["code"] as? String
        
        return bonusObject
    }
    
    // Get Ugc Data
    func getUgcDataFrom(_ ugcObject: Any?) -> UgcData? {
        
        guard let ugcData = ugcObject as? Dictionary<String, Any> else {
            return nil
        }
        
        let ugcDetails = UgcData()
        ugcDetails.userId = ugcData["userId"] as? String
        ugcDetails.ugcId = ugcData["id"] as? String
        
        return ugcDetails
    }
    
    // Get Token Data
    func getTokenDataFrom(_ tokenObject: Any?) -> TokenDetails? {
        
        guard let tokenData = tokenObject as? Dictionary<String, Any> else {
            return nil
        }
        
        let tokenDetails = TokenDetails()
        tokenDetails.accessToken = tokenData["access_token"] as? String
        tokenDetails.refreshToken = tokenData["refresh_token"] as? String
        tokenDetails.firebaseToken = tokenData["firebase_token"] as? String
        tokenDetails.iplfirebaseToken = tokenData["ipl_firebase_token"] as? String
        
        return tokenDetails
    }
    
    // Get User Data
    func getUserInfoFrom(_ userObject: Any?) -> UserInfo? {
        
        guard let userData = userObject as? Dictionary<String, Any> else {
            return nil
        }
        
        let userDetails = UserInfo()
        userDetails.userName = userData["username"] as? String
        userDetails.firstName = userData["firstname"] as? String
        
        if let fbLinked = userData["fb_linked"] as? Bool {
            userDetails.fbLinked = fbLinked
        }
        if let existingUser = userData["existing_user"] as? Bool {
            userDetails.existingUser = existingUser
        }
        
        userDetails.lastName = userData["lastname"] as? String
        userDetails.userId = userData["userId"] as? String
        userDetails.phone = userData["phone"] as? String
        userDetails.fbPhone = userData["mobile_from_fb"] as? String
        userDetails.imageUrl = userData["image_url"] as? String
        userDetails.dob = userData["dob"] as? String
        userDetails.address = userData["address"] as? String
        userDetails.middleName = userData["middlename"] as? String
        userDetails.email = userData["email"] as? String
        
        if let mobileVerified = userData["mobile_verified"] as? Bool {
            userDetails.mobileVerified = mobileVerified
        }
        
        
        return userDetails
    }

}

