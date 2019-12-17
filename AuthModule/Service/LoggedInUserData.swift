//
//  LoggedInUserData.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation

class LoggedInUserData: NSObject {
    var referalDetails : ReferalDetails?
    var ugcData : UgcData?
    var tokenDetails : TokenDetails?
    var userInfo : UserInfo?
    var gocashData : GocashData?
    var referralBonus: ReferralBonus?
}

class ReferalDetails: NSObject {
    var referEarnUrl :String?
    var twitterMsg :String?
    var emailBodyData :String?
    var downloadLaunchMsg :String?
    var branchLink :String?
    var userCode :String?
    var downloadReferMsg :String?
    var facebookLink :String?
    var socialMsg :String?
    var emailSubject :String?
    var whatsAppMsg :String?
}

class ReferralBonus: NSObject {
    var goCashEarned: Int?
    var code: String?
}

class UgcData: NSObject {
    var userId: String?
    var ugcId: String?
}

class TokenDetails: NSObject {
    var accessToken: String?
    var refreshToken: String?
    var firebaseToken: String?
    var iplfirebaseToken: String?
}

class GocashData: NSObject {
    var nonVestedGoCash: String?
    var vestedCredits: String?
    var bucketGocash: String?
    var totalCredits: String?
    var maxGocash: String?
    var nonVestedCredtis: String?
    var bucketCredits: String?
    var vestedGoCash: String?
}

class UserInfo: NSObject {
    var userName: String?
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var fbLinked: Bool = false
    var existingUser: Bool = false
    var userId: String?
    var phone: String?
    var fbPhone : String?
    var imageUrl: String?
    var dob: String?
    var address: String?
    var email: String?
    var mobileVerified: Bool = false
}
