//
//  SignInWithPasswordProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation

protocol SignInWithPasswordViewToPresenterProtocol: PresenterBaseProtocol {
    
    var dataSource: [SignInCellType]! { get }
    
    var mobileNumber: String { get }
    
    var password: String? { get set }
    
    func performInitialConfiguration()
    
    func logInUser()
    
    func requestOTP()
    
    func navigateToForgotPasswordScreen()
}

protocol SignInWithPasswordPresenterToViewProtocol: LoginBaseProtocol {

    func requestOtpFailed(error: ErrorData?)
    
    func userLoggedInRequestSucceeded(data: OtpVerifiedData?)
    
    func userLoggedInRequestFailed(error: ErrorData?)
}

protocol SignInWithPasswordPresenterToInteractorProtocol: InteractorBaseProtocol {
    
    func requestOTP(forMobile mobileNumber: String)
    
    func loginUser(forMobile mobileNumber: String, password: String, referralCode:String)
    
}

protocol SignInWithPasswordInteractorToPresenterProtocol: class {
    
    func requestOTPSuccessResponse(resposne: MobileVerifiedData)
    
    func requestOTPFailedResponse(error: ErrorData?)
    
    func requestLoginSuccessResponse(resposne: OtpVerifiedData)
    
    func requestLoginFailedResponse(error: ErrorData?)
}
