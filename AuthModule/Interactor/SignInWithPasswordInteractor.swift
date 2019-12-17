//
//  SignInWithPasswordPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 05/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class SignInWithPasswordInteractor: BaseInteractor {
    
    var presenter: SignInWithPasswordPresenter?
    
    func requestOTP(forMobile mobileNumber: String) {
        AuthService.requestOTPforMobile(mobileNumber, success: { [weak self] (data) in
            guard let response = LoginMobileVerifyParser().parseJSON(data) as? MobileVerifiedData else {
            self?.presenter?.requestOTPFailedResponse(error: nil)
                return
            }
            
            self?.presenter?.requestOTPSuccessResponse(resposne: response)
            
        }) { [weak self] (error) in
            
            self?.presenter?.requestOTPFailedResponse(error: error)
        }
    }
}
