
//
//  LoginModels.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation


class ReverseProfileData: NSObject {
    var isSuccess : Bool = false
    var totalItems: Int = 0
    var profileItems: Array<ProfileData>?
}

class ProfileData: NSObject {
    var fname : String?
    var lname : String?
    var userid : String?
    var phone : String?
    var email : String?
    var title : String?
    var imgURL: String?
}


@objcMembers class ReferralVerifyData: NSObject {
    var message : String?
    var email : String?
    var isSuccess : Bool = false
    var errorData : ErrorData?
}

class MobileVerifiedData:NSObject {
    var isNewUser : Bool = true
    var isExistingUser : Bool = false
    var isVerifiedUser : Bool = false
    var isSendOtp : Bool = false
    var nonce : String?
    var message : String?
    var isSuccess : Bool = false
    
    var errorData : ErrorData?
}

class OtpVerifiedData:NSObject {
    var mobileKey : String?
    var message : String?
    var detailMessage : String?
    var userName : String?
    var isExistingUser : Bool = true
    var userStatus : String?
    var facebookId : String?
    var fbPhone : String?
    //<NITIN>var userStatusType: UserStatusType = .absent
    var isSuccess : Bool = false
    var errorData : ErrorData?
    var newMobile : String?
    
    //<NITIN>var userData : LoggedInUserData?
}

@objcMembers class ErrorData: NSObject {
    var nonFieldErrorMsg : String?
    var referalErrorMsg : String?
    var userNameErrorMsg : String?
    var fbAccessTknMsg : String?
    var errorMsgString : String?
    var fieldErrorKey: String?
}
