//
//  LoginConstants.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class LoginConstants {
    
    static let kBaseServerURL = AuthNetworkUtils.getServer_C() + "/api/auth/"
    static let apiVersionV1 = "v1.0/"
    static let apiVersionV2 = "v2.0/"
    static let apiVersionV6 = "v6/"

    static func verifyReferralCodeUrl() -> String {
        return kBaseServerURL + apiVersionV1 + "check_referral_eligibility/"
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
}
