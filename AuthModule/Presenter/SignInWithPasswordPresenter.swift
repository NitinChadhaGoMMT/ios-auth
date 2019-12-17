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

class SignInWithPasswordPresenter {

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
    
    var password: String?
    
    var interactor: SignInWithPasswordInteractor?
    
    var view: SignInWithPasswordViewController?
    
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
    
    func logInUser(withUsername userName: String, password: String, referralCode: String?) {
        
    }
    
    func requestOTP() {
        interactor?.requestOTP(forMobile: mobileNumber)
    }
    
    func requestOTPSuccessResponse(resposne: MobileVerifiedData) {
        let vc = AuthRouter.shared.navigateToOTPVerificationController(mobileNumber: mobileNumber, nonce: resposne.nonce, isFbSignup: false, isNewUser: false, isverifyMethodOtp: false, referralCode: self.referralCode ?? "")
        view?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func requestOTPFailedResponse(error: ErrorData?) {
        
    }
    
}
