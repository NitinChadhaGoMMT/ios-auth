//
//  ForgotPasswordProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 19/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation

protocol ForgotPasswordViewToPresenterProtocol: class{
    
    var mobile: String { get }
    
    func requestToRegeneratePassword()
    
    func navigateToPreviousScreen(view: UIViewController)
}

protocol ForgotPasswordPresenterToViewProtocol: LoginBaseProtocol {

    func forgotPasswordRequestSuccess(message: String)
    
    func forgotPasswordRequestFailed(message: String)
}

protocol ForgotPasswordPresenterToInteractorProtocol: InteractorBaseProtocol {
    
    func forgotPasswordRequest(withMobile: String)
    
}

protocol ForgotPasswordInteractorToPresenterProtocol: class {
    
    func forgotPasswordRequestSuccedded(response: ReferralVerifyData)
    
    func forgotPasswordRequestFailed(error: ErrorData?)
}
