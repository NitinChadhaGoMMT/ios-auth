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
    
    func verifyMobileNumber(mobileNumber: String) {
        AuthService.checkAccountExistence(with: mobileNumber, success: { [weak self] (data) in
            let response = self?.parseResponse(data: data)
            self?.successResponse(response: response)
        }) { [weak self] error in
            self?.failResponse(error: error)
        }
    }
    
    func successResponse(response: MobileVerifiedData?) {
        presenter?.verificationMobileNumberRequestSucceeded(response: response)
    }
    
    func failResponse(error: ErrorData?) {
        presenter?.verificationMobileNumberRequestFailed(error: error)
    }
    
    func parseResponse(data: Any?) -> MobileVerifiedData? {
        return LoginMobileVerifyParser().parseJSON(data) as? MobileVerifiedData
    }
}
