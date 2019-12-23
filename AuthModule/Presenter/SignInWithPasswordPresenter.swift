//
//  SignInWithPasswordViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 05/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation

public enum UserSignInState {
    case passwordForMobile, passwordForEmail, passwordOTP, emailPassword, emailPasswordLink, emailOrMobile
}

enum SignInCellType: Int {
    case singInText = 0, singInLogo, emailInput, passwordInput, signInButton,signInButtonBlue, signInButtonContinue, orLabelCell, requestOTP, signInFB, tncCell
    
    var height: CGFloat {
        switch self {
        case .singInText:
            return SignInHeaderTableViewCell.height
            
        case .passwordInput:
            return LoginPasswordTableViewCell.height
            
        case .signInButton, .requestOTP:
            return LoginContinueTableViewCell.height
            
        case .orLabelCell:
            return LoginOrTableCell.height
            
        default:
            return 44.0
        }
    }
}

class SignInWithPasswordPresenter: SignInWithPasswordViewToPresenterProtocol, SignInWithPasswordInteractorToPresenterProtocol {

    var password: String?
    
    var interactor: SignInWithPasswordPresenterToInteractorProtocol?
    
    var view: SignInWithPasswordPresenterToViewProtocol?
    
    var referralCode: String?
    var mobileNumber: String
    var isVerifyOTP: Bool
    var state: UserSignInState!
    
    var dataSource: [SignInCellType]!
    
    init(referralCode: String?, mobileNumber: String, isVerifyOTP: Bool, state: UserSignInState) {
        self.referralCode = referralCode
        self.mobileNumber = mobileNumber
        self.isVerifyOTP = isVerifyOTP
        self.state = state
        configureDataSource()
    }
    
    func performInitialConfiguration() {
        view?.showActivityIndicator()
        interactor?.checkForMobileConnectAPI(completionBlock: { [weak self](responseData) in
            self?.view?.hideActivityIndicator()
            if let data = responseData {
                self?.view?.setMConnectData(data: data)
            }
        })
    }
    
    func configureDataSource() {
        switch state {
            
        case .passwordForEmail,.passwordForMobile:
            dataSource = [.singInText,.passwordInput,.signInButtonBlue]
            
        case .passwordOTP:
            dataSource = [.singInText,.passwordInput,.signInButton,.orLabelCell,.requestOTP]
            
        case .emailPassword,.emailPasswordLink:
            dataSource = [.singInLogo, .emailInput, .passwordInput,.signInButton,.orLabelCell, .signInFB]
            
        case .emailOrMobile:
            dataSource = [.singInLogo, .emailInput,.signInButton,.orLabelCell, .signInFB, .tncCell]
            
        default:
            dataSource = []
        }
        
        if state == .passwordOTP {
            SignInGAPManager.logOpenScreenEvent(for: .enterPasswordOrOTP, otherParams: nil)
        }
    }
    
    func logInUser() {
        interactor?.loginUser(forMobile: mobileNumber, password: self.password ?? "", referralCode: referralCode ?? "")
    }
    
    func requestOTP() {
        interactor?.requestOTP(forMobile: mobileNumber)
    }
    
    func requestOTPSuccessResponse(resposne: MobileVerifiedData) {
        let vc = AuthRouter.shared.navigateToOTPVerificationController(mobileNumber: mobileNumber, nonce: resposne.nonce, isFbSignup: false, isNewUser: false, isverifyMethodOtp: false, referralCode: self.referralCode ?? "")
        view?.push(screen: vc!)
    }
    
    func requestOTPFailedResponse(error: ErrorData?) {
        view?.requestOtpFailed(error: error)
    }
    
    func requestLoginSuccessResponse(resposne: OtpVerifiedData) {
        view?.userLoggedInRequestSucceeded(data: resposne)
    }
    
    func requestLoginFailedResponse(error: ErrorData?) {
        view?.userLoggedInRequestFailed(error: error)
    }
    
    func navigateToForgotPasswordScreen() {
        guard let vc = AuthRouter.shared.navigateToForgotPasswordViewController(mobile: mobileNumber) else { return }
        view?.push(screen: vc)
    }
}
