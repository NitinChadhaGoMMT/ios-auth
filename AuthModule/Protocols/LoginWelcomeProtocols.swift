//
//  LoginWelcomeProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

protocol LoginWelcomeViewToPresenterProtocol: class{
    
    var dataSource: [[LoginCellType]] { get }
    
    var currentMobileNumber: String? { get set }
    
    var referralCode: String? { get }
    
    var isFbSignup: Bool { get set }

    var branchDictionary: NSDictionary? { get }
    
    func isValidPhoneNumber(mobileNumber: String?) -> Bool
    
    func performInitialConfiguration()
    
    func checkForMobileConnect()
    
    func verifyMobileNumber(number: String)
    
    func logGAClickEvent(_ type:String)
    
    func resetReferralCode()
    
    func validateReferralCode(_referralCode: String?, isBranchFlow: Bool)
}

protocol LoginWelcomePresenterToViewProtocol: LoginBaseProtocol {

    func resetReferralCode()
    
    func verifyReferralRequestFailed(response: ErrorData?)
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData?)
}

protocol LoginWelcomePresenterToRouterProtocol: class {
    
    func navigateToOTPVerificationController(mobileNumber: String, nonce: String?, isFbSignup: Bool, isNewUser: Bool, isverifyMethodOtp: Bool, referralCode: String) -> UIViewController?
    
    func navigateToPasswordViewController(userState: UserSignInState, referralCode: String, mobile: String, isVerifyOTP: Bool) -> UIViewController?
}

protocol LoginWelcomePresenterToInteractorProtocol: InteractorBaseProtocol {
    
    func verifyReferralCode(referralCode:String, isBranchFlow:Bool)
    
    func verifyMobileNumber(mobileNumber: String)
    
}

protocol LoginWelcomeInteractorToPresenterProtocol: class {
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData?)
    
    func verifyReferralRequestFailed(response: ErrorData?)
    
    func verificationMobileNumberRequestSucceeded(response: MobileVerifiedData?)
}
