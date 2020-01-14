//
//  AuthRouter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import FBSDKCoreKit

public class AuthRouter {

    public static let shared = AuthRouter()
    
    public var pushController: UIViewController?
    
    public var completionBlock: ((Bool, Error?) -> Void)?
    
    var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Auth",bundle: AuthUtils.bundle)
    }
    
    private init() {
        Settings.appID = "151974918280687"
    }
    
    public func initiateLoginModule() -> UIViewController? {
        
        if let dictionary = AuthDepedencyInjector.branchReferDictionary, let _ = dictionary.object(forKey: "refercode") as? String {
            guard let view: ReferralCodeValidationViewController = mainstoryboard.getViewController() else {
                return nil
            }
            
            let presenter = ReferralCodeValidationPresenter()
            let interactor = ReferralCodeInteractor()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return view
        } else {
            
            guard let view: OnboardingWelcomeContainer = mainstoryboard.getViewController() else {
                return nil
            }
            return view
        }
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
    
    func navigateToMobileVerificationController(mobile: String?, data: PresenterCommonData) -> UIViewController? {
        
        guard let view: MobileVerificationViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = MobileVerificationPresenter(mobile: mobile, data: data)
        let interactor = LoginWelcomeInteractor()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    public func goToHomePage(vc: UIViewController) {
        if let controller:TempViewController = AuthRouter.shared.mainstoryboard.getViewController() {
            vc.navigationController?.pushViewController(controller, animated: true)
        }
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
    
    func navigateBackToSourceController(isUserLoggedIn success:Bool, navigationController: UINavigationController?) {
        guard let navigationController = navigationController else { return }
        
        if let pushController = pushController {
            navigationController.isNavigationBarHidden = false
            if navigationController.viewControllers.contains(pushController) {
                navigationController.popToViewController(pushController, animated: false)
            } else {
                navigationController.popToRootViewController(animated: false)
            }
            
            if let completionBlock = completionBlock {
                completionBlock(false, nil)
            }
        } else {
            if let completionBlock = completionBlock {
                completionBlock(false, nil)
            }
            
            AuthDepedencyInjector.uiDelegate?.authLoginCompletion(isUserLoggedIn: false, error: nil)
        }
    }
    
    func signupSuccessNavigationHandling(cta:CTAItem?, navigationController: UINavigationController?) {
        
        guard let navigationController = navigationController else { return }
    
        if let pushController = pushController {
            navigationController.isNavigationBarHidden = false
            if navigationController.viewControllers.contains(pushController) {
                navigationController.popToViewController(pushController, animated: false)
            } else {
                navigationController.popToRootViewController(animated: false)
            }
            
            if let loginBlock = completionBlock {
                loginBlock(true, nil)
            }
//
            return
        }
        
        if let isSyncScreenEnable = FireBaseHandler.getBoolFor(keyPath: .onboardingSyncScreenShown, dbPath: .goCoreDatabase), isSyncScreenEnable == true {
            openConfirmationVC()
        } else {
            //<NITIN>AppRouter.navigateToEarn(goDataModel: nil, animated: false, completionBlock: nil)
        }
    }
    
    func openConfirmationVC() {
        
    }
    
    func presentReferralCodeAlert(delegate: ReferralCodeProtocol) -> UIViewController? {
        
        guard let view: ReferralCodeViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = ReferralCodePresenter(_delegate: delegate)
        let interactor = ReferralCodeInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}

extension AuthRouter: LoginWelcomePresenterToRouterProtocol {
    
    func navigateToPasswordViewController(userState: UserSignInState, mobile: String, data: PresenterCommonData) -> UIViewController? {
        
        guard let view: SignInWithPasswordViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = SignInWithPasswordPresenter(mobileNumber: mobile, state: userState, data: data)
        let interactor = SignInWithPasswordInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToOTPVerificationController(mobile: String, data: PresenterCommonData, nonce: String?, isNewUser: Bool) -> UIViewController? {
    
        guard let view: OtpVerificationViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = OTPVerificationPresenter(mobileNumber: mobile, nonce: nonce, isNewUser: isNewUser, data: data)
        let interactor = OTPVerificationInteractor()
        
        presenter.view = view
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = self
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToSignUpController(data: PresenterCommonData, extraKeys: String?) -> UIViewController? {
    
        guard let view: SignupViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = SignUpPresenter(data: data, _extraKeys: extraKeys)
        let interactor = SignupInteractor()
        
        view.presenter = presenter
        presenter.view = view
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        return view
    }
    
    func navigateToTermsAndConditions() -> UIViewController? {
        
        if let view: WebViewController = mainstoryboard.getViewController() {
            view.titleString = "Terms and Conditions"
            view.urlString = "https://www.goibibo.com/info/terms-and-conditions/"
            return view
        }

        return nil
    }
    
    func navigateToPrivacyPolicy() -> UIViewController? {
        
        if let view: WebViewController = mainstoryboard.getViewController() {
            view.titleString = "Privacy Policy"
            view.urlString = "https://www.goibibo.com/info/privacy-policy"
            return view
        }
        return nil
    }
    
    func navigateToUserAgreement() -> UIViewController? {
        
        if let view: WebViewController = mainstoryboard.getViewController() {
            view.titleString = "User Agreement"
            view.urlString = "https://www.goibibo.com/info/user-agreement/"
            return view
        }
        return nil
    }
}
