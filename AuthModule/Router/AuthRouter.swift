//
//  AuthRouter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

public class AuthRouter {

    public static let shared = AuthRouter()
    
    public var pushController: UIViewController?
    
    public var completionBlock: ((Bool, Error?) -> Void)?
    
    var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Auth",bundle: AuthUtils.bundle)
    }
    
    public func createModule() -> UIViewController? {
        
        guard let view: LoginWelcomeViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = LoginWelcomePresenter()
        let interactor = LoginWelcomeInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = AuthRouter.shared
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        return view
    }
    
    func navigateToSignUpController(referralCodde: String, otpResponse: OtpVerifiedData?) -> UIViewController? {
    
        guard let view: SignupViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = SignUpPresenter(referralCodde: referralCodde, otpResponse: otpResponse)
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func navigateToForgotPasswordViewController(mobile: String) -> UIViewController? {
        
        guard let view: ForgotPasswordViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = ForgotPasswordPresenter(mobile: mobile)
        let interactor = ForgotPasswordInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.router = self
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }

    func presentKeychainLoginViewController() -> UIViewController? {
        guard let view: KeyChainLoginViewController = mainstoryboard.getViewController() else {
           return nil
        }
        view.presenter = KeyChainLoginPresenter()
        return view
    }
    
    func popCurrentViewController(vc: UIViewController) {
        vc.navigationController?.popViewController(animated: true)
    }
}

extension AuthRouter: LoginWelcomePresenterToRouterProtocol {
    
    public func navigateToPasswordViewController(userState: UserSignInState, referralCode: String, mobile: String, isVerifyOTP: Bool) -> UIViewController? {
        
        guard let view: SignInWithPasswordViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = SignInWithPasswordPresenter(referralCode: referralCode, mobileNumber: mobile, isVerifyOTP: isVerifyOTP, state: userState)
        let interactor = SignInWithPasswordInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    public func navigateToOTPVerificationController(mobileNumber: String, nonce: String?, isFbSignup: Bool, isNewUser: Bool, isverifyMethodOtp: Bool, referralCode: String) -> UIViewController? {
        guard let view: OtpVerificationViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = OTPVerificationPresenter(mobileNumber: mobileNumber, nonce: nonce, isFbSignup: isFbSignup, isNewUser: isNewUser, isverifyMethodOtp: isverifyMethodOtp, referralCode: referralCode)
        let interactor = OTPVerificationInteractor()
        
        presenter.view = view
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = self
        interactor.presenter = presenter
        
        return view
    }
}
