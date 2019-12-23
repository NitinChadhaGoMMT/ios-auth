//
//  ForgotPasswordInteractor.swift
//  AuthModule
//
//  Created by Nitin Chadha on 17/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class ForgotPasswordInteractor: BaseInteractor, ForgotPasswordPresenterToInteractorProtocol {

    weak var presenter: ForgotPasswordInteractorToPresenterProtocol?
    
    func forgotPasswordRequest(withMobile mobile: String) {
        AuthService.forgotPasswordRequest(withMobile: mobile, success: { [weak self](data) in
            guard let response = LoginVerifyReferralParser().parseJSON(data) as? ReferralVerifyData else {
                self?.presenter?.forgotPasswordRequestFailed(error: nil)
                return
            }
            self?.presenter?.forgotPasswordRequestSuccedded(response: response)
        }) { [weak self](error) in
            self?.presenter?.forgotPasswordRequestFailed(error: error)
        }
    }
}
