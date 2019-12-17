
//
//  SignUpPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 11/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class SignUpPresenter {
    
    enum SignUpCellTypes {
        case almostThere, FBConnect, orLabel, createProfile, firstName, middleName, lastName, emailInput, signUpHeader
        
        var height: CGFloat {
            switch self {
            case .signUpHeader:
                return SignUpHeaderTableCell.height
                
            case .firstName:
                return SignUpTextInputViewCell.height
                
            default:
                return 44.0
            }
        }
        
    }
    
    weak var view: SignupViewController?
    
    var mobileKey: String?
    var existingFbId: String?
    
    init(referralCodde: String, otpResponse: OtpVerifiedData?) {
        self.mobileKey = otpResponse?.mobileKey
        self.existingFbId = otpResponse?.facebookId
    }
    
    var dataSource: [SignUpCellTypes] = [.signUpHeader, .firstName]
}
