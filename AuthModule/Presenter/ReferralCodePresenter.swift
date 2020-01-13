//
//  ReferralCodePresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol ReferralCodeProtocol: class {
    func applyReferralCode(code: String)
}

class ReferralCodePresenter: ReferralCodeViewToPresenterProtocol, ReferralCodeInteractorToPresenterProtocol {
    
    var interactor: ReferralCodeInteractor?
    
    weak var view: ReferralCodePresenterToViewProtocol?
    
    weak var delegate: ReferralCodeProtocol?
    
    var referralCodeEntered: String?
    
    init(_delegate: ReferralCodeProtocol) {
        self.delegate = _delegate
    }
    
    func isValid() -> Bool {
        return !AuthUtils.isEmptyString(referralCodeEntered)
    }
    
    func validateReferralCode() {
        if let referralCode = referralCodeEntered, isValid() {
            view?.showActivityIndicator()
            interactor?.verifyReferralCode(referralCode: referralCode)
        }
    }
    
    func verifyReferralRequestFailed(error: ErrorData?) {
        view?.hideActivityIndicator()
        view?.showReferralError()
    }
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData) {
        view?.hideActivityIndicator()
        delegate?.applyReferralCode(code: referralCodeEntered ?? "")
        view?.dismiss()
    }
    
}
