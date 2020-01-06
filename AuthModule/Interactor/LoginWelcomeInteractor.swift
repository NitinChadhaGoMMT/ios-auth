//
//  LoginWelcomeInteractor.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class LoginWelcomeInteractor: BaseInteractor, LoginWelcomePresenterToInteractorProtocol {
    
    weak var presenter: LoginWelcomeInteractorToPresenterProtocol?
    
    func verifyReferralCode(referralCode:String, isBranchFlow:Bool) {
        AuthService.verifyReferralCode(referralCode: referralCode, isBranchFlow: isBranchFlow, success: { (data) in
            let response = LoginVerifyReferralParser().parseJSON(data) as? ReferralVerifyData
            self.presenter?.verifyReferralSuccessResponse(response: response)
            
        }) { [weak self] (errorData) in
            self?.presenter?.verifyReferralRequestFailed(error: errorData)
        }
    }
    
    func verifyMobileNumber(mobileNumber: String) {
        AuthService.checkAccountExistence(with: mobileNumber, success: { [weak self] (data) in
            let response = LoginMobileVerifyParser().parseJSON(data) as? MobileVerifiedData
            self?.presenter?.verificationMobileNumberRequestSucceeded(response: response)
        }) { [weak self] error in
            self?.presenter?.verificationMobileNumberRequestFailed(error: error)
        }
    }
}