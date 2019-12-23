//
//  ForgotPasswordPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 17/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class ForgotPasswordPresenter: ForgotPasswordViewToPresenterProtocol, ForgotPasswordInteractorToPresenterProtocol {

    var view: ForgotPasswordPresenterToViewProtocol?
    var interactor: ForgotPasswordPresenterToInteractorProtocol?
    var router: AuthRouter?
    var mobile: String
    
    init(mobile: String) {
        self.mobile = mobile
    }
    
    func requestToRegeneratePassword() {
        interactor?.forgotPasswordRequest(withMobile: mobile)
    }
    
    func forgotPasswordRequestSuccedded(response: ReferralVerifyData) {
        
        if response.isSuccess {
            view?.forgotPasswordRequestSuccess(message: response.message ?? "Validation sent")
        } else {
            view?.forgotPasswordRequestFailed(message: response.message ?? "Unable to process this request")
        }
    }
    
    func forgotPasswordRequestFailed(error: ErrorData?) {
        var errorMessage = "Unable to process this request"
        if let errorObj = error {
            errorMessage = errorObj.nonFieldErrorMsg ?? errorObj.errorMsgString ?? "Unable to process this request"
        }
        view?.forgotPasswordRequestFailed(message: errorMessage)
    }
    
    func navigateToPreviousScreen(view: UIViewController) {
        router?.popCurrentViewController(vc: view)
    }
}
