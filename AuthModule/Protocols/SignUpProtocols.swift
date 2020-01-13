//
//  SignUpProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol SignUpViewToPresenterProtocol: class {
    
    var referralCode: String? { get }
    
    var isValidName: Bool { get }
    
    var fullName: String? { get set }
    
    func showReferralCodeInputView()
    
    func requestSignUp()
}

protocol SignUpPresenterToViewProtocol: LoginBaseProtocol {
    
    func refreshReferralCodeView()
    
}

protocol SignUpPresenterToInteractorProtocol: InteractorBaseProtocol {
    
     func requestToSignUp(_ fullName:String, mobileKey:String, referalCode:String, isWhatsAppFlow:Bool, extraKey:String?)
}

protocol SignUpInteractorToPresenterProtocol: class {
    
    func signUpRequestSuccess(otpVerifiedData: OtpVerifiedData?)
    
    func signUpRequestFailed(error: ErrorData?)
}
