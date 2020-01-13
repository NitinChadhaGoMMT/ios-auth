//
//  ReferralCodeValidationProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol ReferralCodeValidationViewToPresenterProtocol: class {
    
    func validateReferralCodeFromDeepLink()
}

protocol ReferralCodeValidationPresenterToViewProtocol: LoginBaseProtocol {
    
    func referralCodeSuccess()
    
    func referralCodeFailure()
}
