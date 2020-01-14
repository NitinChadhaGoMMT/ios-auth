//
//  LoginWelcomeProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

protocol LoginWelcomeViewToPresenterProtocol: PresenterBaseProtocol {
    
    var dataSource: [[LoginCellType]] { get }
    
    var currentMobileNumber: String? { get set }

    var referralFirstName: String? { get }
    
    var showReferralStatus: Bool { get }
    
    func isValidPhoneNumber(mobileNumber: String?) -> Bool
    
    func performInitialConfiguration()
    
    func checkForMobileConnect()
    
    func verifyMobileNumber(number: String)
    
    func signInWithFB()
    
    func requestFBOTPWithMobileNo(_ mobileNo: String)
    
    func logGAClickEvent(_ type:String)
    
    func navigateToPostMobileNumberScreen(verifiedData: MobileVerifiedData)
    
    func navigateToSignUpScreen()
    
    func navigateToTermsAndConditions()
    
    func navigateToPrivacyPolicy()
    
    func navigateToUserAgreement()
}

protocol LoginWelcomePresenterToViewProtocol: LoginBaseProtocol {

    func verifyMobileNumberRequestFailed(error: ErrorData?)

}

protocol LoginWelcomePresenterToRouterProtocol: class {
    
    func navigateToOTPVerificationController(mobile: String, data: PresenterCommonData, nonce: String?, isNewUser: Bool) -> UIViewController? 
    
    func navigateToPasswordViewController(userState: UserSignInState, mobile: String, data: PresenterCommonData) -> UIViewController? 
    
    func navigateToSignUpController(data: PresenterCommonData, extraKeys: String?) -> UIViewController?
    
    func navigateToTermsAndConditions() -> UIViewController?
    
    func navigateToPrivacyPolicy() -> UIViewController?
    
    func navigateToUserAgreement() -> UIViewController?
}

extension LoginWelcomePresenterToRouterProtocol {
    
    func navigateToSignUpController(data: PresenterCommonData) -> UIViewController? {
        self.navigateToSignUpController(data: data, extraKeys: nil)
    }
    
}

protocol LoginWelcomePresenterToInteractorProtocol: InteractorBaseProtocol {
    
    func verifyMobileNumber(mobileNumber: String)
    
}

protocol LoginWelcomeInteractorToPresenterProtocol: class {
    
    func verificationMobileNumberRequestSucceeded(response: MobileVerifiedData?)
    
    func verificationMobileNumberRequestFailed(error: ErrorData?)
}

