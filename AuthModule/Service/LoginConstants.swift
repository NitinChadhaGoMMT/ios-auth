//
//  LoginConstants.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

enum LogoutType {
    case user
    case api
}

class LoginConstants {
    
    static let kBaseServerURL = AuthNetworkUtils.getServer_C() + "/api/auth/"
    static let apiVersionV1 = "v1.0/"
    static let apiVersionV2 = "v2.0/"
    static let apiVersionV5 = "v5/"
    static let apiVersionV6 = "v6/"
    static let kFBAccessToken = "fb_access_token"

    static func verifyReferralCodeUrl() -> String {
        return kBaseServerURL + apiVersionV1 + "check_referral_eligibility/"
    }
    
    static func forgotPasswordUrl() -> String {
        return kBaseServerURL + apiVersionV1 + "resetpwd/"
    }
    
    static func requestOTPUrl() -> String {
        return kBaseServerURL + apiVersionV1 + "request_login_otp/"
    }
    
    static func verifyOTPUrl() -> String {
        return kBaseServerURL + apiVersionV6 + "verify_login_otp/"
    }
    
    static func mConnectGetDeviceDetailsUrl() -> String {
        return kBaseServerURL + apiVersionV2 + "mobileconnect/get_device_details/"
    }
    
    static func logoutUser() -> String {
        return AuthNetworkUtils.getServer_C() + "/logout/"
    }
    
    static func fbSignupAccountUrl() -> String {
        return kBaseServerURL + apiVersionV5 + "facebook_connect/"
    }
    
    static func refreshTokenUrl() -> String {
        return AuthNetworkUtils.getServer_C() + "/api/oauth/token/"
    }
    
    static func userInfoUrl() -> String {
        return AuthNetworkUtils.getServer_Auth() + "/v5/api/user/"
    }
    
    static func amigoReverseProfileUrl() -> String {
        return AuthNetworkUtils.getAmigoServer()  + "/v1/" + "getreverseprofiles"
    }
    
    static func createAccountUrl() -> String {
        return AuthNetworkUtils.getServer_Auth() + "/authapi/" + apiVersionV6 + "mobile/register/"
    }
}
