//
//  MobileVerificationProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 30/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

protocol MobileVerificationViewToPresenterProtocol: PresenterBaseProtocol {
    
    func checkForMobileConnect()
    
    func verifyMobileNumber(number: String)
    
    func requestFBOTPWithMobileNo(_ mobileNo: String)
    
    func navigateToPasswordScreen(verifiedData: MobileVerifiedData?)
    
}

protocol MobileVerificationPresenterToViewProtocol: LoginBaseProtocol { }
