//
//  BasePresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 08/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

struct PresenterCommonData {
    var isverifyMethodOtp: Bool = true
    var isFbSignup: Bool = false
    var isWhatsAppLogin: Bool = false
    var referralCode: String?
    var userVerificationData: OtpVerifiedData? = nil
}

class BasePresenter: PresenterBaseProtocol {

    var commonData: PresenterCommonData
    
    var isWhatsAppLogin: Bool {
        set {
            commonData.isWhatsAppLogin = newValue
        }
        get {
            return commonData.isWhatsAppLogin
        }
    }
    
    var isFbSignup: Bool {
        set {
            commonData.isFbSignup = newValue
        }
        get {
            return commonData.isFbSignup
        }
    }
    
    var isverifyMethodOtp: Bool {
        set {
            commonData.isverifyMethodOtp = newValue
        }
        get {
            return commonData.isverifyMethodOtp
        }
    }
    
    var referralCode: String? {
        set {
            commonData.referralCode = newValue
        }
        get {
            return commonData.referralCode
        }
    }
    
    var userVerificationData: OtpVerifiedData? {
        set {
            commonData.userVerificationData = newValue
        }
        get {
            return commonData.userVerificationData
        }
    }
    
    init() {
        commonData = PresenterCommonData(isverifyMethodOtp: true, isFbSignup: false, referralCode: nil, userVerificationData: nil)
    }
    
    init(_ isverifyMethodOtp: Bool, isFbSignup: Bool, referralCode: String?, userVerificationData: OtpVerifiedData?) {
        commonData = PresenterCommonData(isverifyMethodOtp: isverifyMethodOtp, isFbSignup: isFbSignup, referralCode: referralCode, userVerificationData: userVerificationData)
    }
    
    init(dataModel data: PresenterCommonData) {
        commonData = data
    }
    
}
