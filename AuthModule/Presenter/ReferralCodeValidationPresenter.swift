//
//  ReferralCodeValidationPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

fileprivate let minimumWaitingTime: Double = 5

class ReferralCodeValidationPresenter: BasePresenter, ReferralCodeValidationViewToPresenterProtocol {

    var screenTimer: DispatchTime?
    
    var interactor: ReferralCodePresenterToInteractorProtocol?
    weak var view: ReferralCodeValidationPresenterToViewProtocol?
    
    func startTimer() {
        screenTimer = DispatchTime.now()
    }
    
    func validateReferralCodeFromDeepLink() {
        
        startTimer()
        
        if let codeDictionary = AuthDepedencyInjector.branchReferDictionary {
            if let _referralCode = codeDictionary.object(forKey: Keys.referCode) as? String {
                self.referralCode = _referralCode
                interactor?.verifyReferralCode(referralCode: _referralCode)
            }
        }
    }
    
    fileprivate func getTimeInterval() -> Int {
        let endTime = DispatchTime.now()
        let nanoTime = endTime.uptimeNanoseconds - (screenTimer?.uptimeNanoseconds ?? 0)
        let timeInterval = Double(nanoTime) / 1_000_000_000
        
        return Int(timeInterval)
    }
    
    fileprivate func preCheckToPushLoginScreen() {
        let time =  self.getTimeInterval()
        if time >= Int(minimumWaitingTime) {
            self.pushLoginScreen()
        } else {
            Timer.scheduledTimer(timeInterval: minimumWaitingTime, target: self, selector: #selector(pushLoginScreen), userInfo: nil, repeats: false)
        }
    }
    
    @objc func pushLoginScreen() {
        if let new_vc = AuthRouter.shared.createModule() {
            view?.push(screen: new_vc)
        }
    }
}

extension ReferralCodeValidationPresenter: ReferralCodeInteractorToPresenterProtocol {
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData) {
        view?.referralCodeSuccess()
        preCheckToPushLoginScreen()
    }
    
    func verifyReferralRequestFailed(error: ErrorData?) {
        self.referralCode = nil
        AuthUtils.removeBranchReferCode()
        view?.referralCodeFailure()
        preCheckToPushLoginScreen()
    }
    
}
