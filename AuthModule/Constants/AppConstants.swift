//
//  AppConstants.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

extension Notification {
    static let chainUpdate = Notification.Name(rawValue: "ChainUpdate")
}

extension String {
    
    static let goibibo = "Goibibo"
    static let genericError = "Something wrent wrong. Please try again later."
    static let privacyPolicy = "Privacy Policy"
    static let userAgreement = "User Agreement"
    
    //ReferralCodeValidation
    static let kInvalidCodeMsg = "Invalid Code. Add this later on."
    static let kValidCodeMsg = "Referral Code applied!"
    
    static let kEmptyString = ""
    static let kHiphen = ""
    static let kDismiss = "Dismiss"
    static let kNext = "NEXT"
    static let kClickHere = "Click here"
    static let kContinue = "Continue"
    
    //Onboarding
    static let kGetStarted = "GET STARTED"
    static let kFirstHeader = "ONE APP FOR ALL \n YOUR TRAVEL NEEDS"
    static let kFirstSubHeader = "Book Hotels, Flights, Trains, Bus, Cabs \n and Experiences all in one app"
    static let kSecondHeader = "5+ CRORES \n HAPPY USERS"
    static let kSecondSubHeader = "Trusted by 5+ crores Indians \n for their travel booking needs."
    static let kThreeHeader = "CHEAPEST PRICE \n GUARANTEED"
    static let kThreeSubHeader = "Book hotels with best price guaranteed \n starting at Rs.599"
    
    //LoginWelcomeViewController
    
    static let kReferralCode = "Referral Code"
    static let kInviteReferralText = "Have a referral code?"
    static let kEnterCode = "Enter Code"
    
    static let kInvalidNumberMessage = "Please enter valid mobile number"
    static let kMobileNumberPlaceholder = "Enter Mobile Number"
    static let kTnCText = "By Proceeding, you agree to Terms and Conditions."
    static let kTnC = "Terms and Conditions"
    
    //SignInViewController
    static let kResendOTP = "Resend OTP"
    static let kResendOTPIn = "Resend OTP in"
}

struct Keys {
    static let facebookAppId = "151974918280687"
    static let referCode = "refercode"
    static let firebaseToken = "firebase_token"
    static let iplFirebaseToken = "ipl_firebase_token"
    static let tokenType = "token_type"
    static let expiresIn = "expires_in"
    static let tokenExpiry = "token_expiry"
    static let bearerToken = "bearer_token"
    static let error = "error"
    
    //Network Keys
    static let referralCode = "referral_code"
    static let clientId = "client_id"
    static let did = "did"
    static let deviceId = "device_id"
    static let accessToken = "access_token"
    static let refreshToken = "refresh_token"
}
