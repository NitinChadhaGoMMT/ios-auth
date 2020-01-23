//
//  AuthRouter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import FBSDKCoreKit

public typealias LoginCompletionBlock = ((Bool, Error?) -> Void)

public class AuthRouter {
    
    public static var shared = AuthRouter()

    var pushController: UIViewController?
    
    var completionBlock: LoginCompletionBlock?
    
    var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Auth", bundle: AuthUtils.bundle)
    }
    
    private init() {
        Settings.appID = Keys.facebookAppId
    }
    
    public func invokeLoginFlow(from viewController: UIViewController? = nil,
                                onNavigationStack navigationController: UINavigationController?,
                                completionBlock: LoginCompletionBlock? = nil) {
        
        self.completionBlock = completionBlock
        self.pushController = viewController
        
        guard  UserDataManager.shared.isLoggedIn == false else {
            finishLoginFlow(error: nil)
            return
        }
        
        if let loginWelcomeScreen = navigateToLoginWelcomeController() {
            navigationController?.pushViewController(loginWelcomeScreen, animated: true)
        } else {
            finishLoginFlow(error: nil)
        }
    }
    
    
    public func invokeLoginFlowFromBranch(from viewController: UIViewController? = nil,
                                          onNavigationStack navigationController: UINavigationController?,
                                          completionBlock: @escaping ((Bool, Error?) -> Void)) {
        
        self.pushController = viewController
        self.completionBlock = completionBlock
        
        guard  UserDataManager.shared.isLoggedIn == false else {
            finishLoginFlow(error: nil)
            return
        }
        
        if let loginWelcomeScreen = navigateToReferralValidationController() {
            navigationController?.pushViewController(loginWelcomeScreen, animated: true)
        } else {
            finishLoginFlow(error: nil)
        }
    }
    
    func navigateToReferralValidationController() -> UIViewController? {
        
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
            
            guard let view = navigateToLoginWelcomeController() else {
            //guard let view: OnboardingWelcomeContainer = mainstoryboard.getViewController() else {
                return nil
            }
            return view
        }
    }
    
    func navigateToLoginWelcomeController() -> UIViewController? {
        
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
    
    static public func goToHomePage(vc: UIViewController) {
        if let controller:TempViewController = shared.mainstoryboard.getViewController() {
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
    
    func signupSuccessNavigationHandling() {
        
        AuthDataProvider.isExistingUser = false

        AuthDepedencyInjector.uiDelegate?.userLoggedInSuccessfully()
        
        finishLoginFlow(error: nil)

    }
    
    func loginSuccessNavigationHandling(navigationController: UINavigationController?, isExistingUser: Bool) {
        
        AuthDataProvider.isExistingUser = isExistingUser
        
        if pushController == nil {
            AuthDepedencyInjector.uiDelegate?.removeBranchReferCode()
        }
        
        AuthDepedencyInjector.uiDelegate?.userLoggedInSuccessfully()
        
        finishLoginFlow(error: nil)
    }
    
    func navigateBackToSourceController() {
        guard let navigationController = pushController?.navigationController else { return }
        
        if let pushController = pushController {
            navigationController.isNavigationBarHidden = false
            if navigationController.viewControllers.contains(pushController) {
                navigationController.popToViewController(pushController, animated: false)
            } else {
                navigationController.popToRootViewController(animated: false)
            }
        }
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
    
    func finishLoginFlow(error: Error?) {
        
        navigateBackToSourceController()
        
        if let completionBlock = completionBlock {
            completionBlock(UserDataManager.shared.isLoggedIn, error)
        }

        self.completionBlock = nil
        self.pushController = nil
    }
    
    public func logoutUser(completionBlock: LoginCompletionBlock?) {
        UserDataManager.shared.logout(type: .user, completionBlock: completionBlock)
    }
    
    public func loginViaWhatsApp(token: String?, referralCode: String?, extraKeys: String?, navigationController: UINavigationController?) {
        WhatsappHelper.shared.handleToken(token: token, referralCode: referralCode, extraKeys: extraKeys, navigationController: navigationController)
    }
    
    public func goServiceUserInfoLogin(_ sender: UIViewController?, pop: Bool, finishedVC: UIViewController?, onError: @escaping (Any?) -> Void, onFinished: @escaping (Any?) -> Void) {
        LoginWrapper.goServiceUserInfoLogin(sender, pop: pop, finishedVC: finishedVC, onError: onError, onFinished: onFinished)
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
            view.titleString = .kTnC
            view.urlString = URLBuilder.termsAndConditionsURL
            return view
        }

        return nil
    }
    
    func navigateToPrivacyPolicy() -> UIViewController? {
        
        if let view: WebViewController = mainstoryboard.getViewController() {
            view.titleString = .privacyPolicy
            view.urlString = URLBuilder.privacyPolicyURL
            return view
        }
        return nil
    }
    
    func navigateToUserAgreement() -> UIViewController? {
        
        if let view: WebViewController = mainstoryboard.getViewController() {
            view.titleString = .userAgreement
            view.urlString = URLBuilder.userAgreementURL
            return view
        }
        return nil
    }
}
