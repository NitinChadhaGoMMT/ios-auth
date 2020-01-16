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
    
    static var shared = AuthRouter()

    var pushController: UIViewController?
    
    var completionBlock: LoginCompletionBlock?
    
    var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Auth", bundle: AuthUtils.bundle)
    }
    
    private init() {
        Settings.appID = Keys.facebookAppId
    }
    
    public static func invokeLoginFlow(from viewController: UIViewController? = nil,
                                onNavigationStack navigationController: UINavigationController?,
                                completionBlock: LoginCompletionBlock? = nil) {
        
        shared = AuthRouter()
        shared.completionBlock = completionBlock
        shared.pushController = viewController
        
        guard  UserDataManager.shared.isLoggedIn == false else {
            shared.finishLoginFlow(error: nil)
            return
        }
        
        if let loginWelcomeScreen = shared.navigateToLoginWelcomeController() {
            navigationController?.pushViewController(loginWelcomeScreen, animated: true)
        } else {
            shared.finishLoginFlow(error: nil)
        }
    }
    
    public static func invokeLoginFlowFromBranch(from viewController: UIViewController? = nil,
                                          onNavigationStack navigationController: UINavigationController?,
                                          completionBlock: @escaping ((Bool, Error?) -> Void)) {
        
        shared = AuthRouter()
        shared.pushController = viewController
        shared.completionBlock = completionBlock
        
        guard  UserDataManager.shared.isLoggedIn == false else {
            shared.finishLoginFlow(error: nil)
            return
        }
        
        if let loginWelcomeScreen = shared.navigateToReferralValidationController() {
            navigationController?.pushViewController(loginWelcomeScreen, animated: true)
        } else {
            shared.finishLoginFlow(error: nil)
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
    
    func signupSuccessNavigationHandling(navigationController: UINavigationController?) {
        
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
            return
        }
        
        if let controller:TempViewController = mainstoryboard.getViewController() {
            navigationController.pushViewController(controller, animated: true)
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
    
    func finishLoginFlow(error: Error?) {
        
        navigateBackToSourceController()
        
        if let completionBlock = completionBlock {
            completionBlock(UserDataManager.shared.isLoggedIn, error)
        }

        self.completionBlock = nil
        self.pushController = nil
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
