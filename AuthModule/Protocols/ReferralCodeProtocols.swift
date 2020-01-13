//
//  ReferralCodeProtocol.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol ReferralCodeViewToPresenterProtocol: class {
    
    var referralCodeEntered: String? { get set }
    
    func isValid() -> Bool
    
    func validateReferralCode()
}

protocol ReferralCodePresenterToViewProtocol: LoginBaseProtocol {
    
    func showReferralError()
}

protocol ReferralCodePresenterToInteractorProtocol: InteractorBaseProtocol {
    
    func verifyReferralCode(referralCode:String)
     
}

protocol ReferralCodeInteractorToPresenterProtocol: class {
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData)
    
    func verifyReferralRequestFailed(error: ErrorData?)
}

