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

class SignInWithPasswordPresenter: BasePresenter, SignInWithPasswordViewToPresenterProtocol, SignInWithPasswordInteractorToPresenterProtocol {

    var password: String?
    
    var interactor: SignInWithPasswordPresenterToInteractorProtocol?
    
    var view: SignInWithPasswordPresenterToViewProtocol?
    
    var mobileNumber: String
    var state: UserSignInState!
    
    var dataSource: [SignInCellType]!
    
    init(mobileNumber: String, state: UserSignInState, data: PresenterCommonData) {
        self.mobileNumber = mobileNumber
        self.state = state
        super.init(dataModel: data)
        configureDataSource()
    }
    
    func performInitialConfiguration() {
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
        view?.showActivityIndicator()
        interactor?.loginUser(forMobile: mobileNumber, password: self.password ?? "", referralCode: referralCode ?? "")
    }
    
    func requestOTP() {
        view?.showActivityIndicator()
        interactor?.requestOTP(forMobile: mobileNumber)
    }
    
    func requestOTPSuccessResponse(resposne: MobileVerifiedData) {
        view?.hideActivityIndicator()
        if let vc = AuthRouter.shared.navigateToOTPVerificationController(mobile: mobileNumber, data: commonData, nonce: resposne.nonce, isNewUser: false) {
            view?.push(screen: vc)
        }
    }
    
    func requestOTPFailedResponse(error: ErrorData?) {
        view?.hideActivityIndicator()
        view?.requestOtpFailed(error: error)
    }
    
    func requestLoginSuccessResponse(resposne: OtpVerifiedData) {
        view?.hideActivityIndicator()
        view?.userLoggedInRequestSucceeded(data: resposne)
    }
    
    func requestLoginFailedResponse(error: ErrorData?) {
        view?.hideActivityIndicator()
        view?.userLoggedInRequestFailed(error: error)
    }
    
    func navigateToForgotPasswordScreen() {
        guard let vc = AuthRouter.shared.navigateToForgotPasswordViewController(mobile: mobileNumber) else { return }
        view?.push(screen: vc)
    }
}
