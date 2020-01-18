//
//  AuthDepedencyInjector.swift
//  AuthModule
//
//  Created by Nitin Chadha on 29/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

public protocol AuthModuleUIProtocol {

    func showActivityIndicator(on view: UIView)
    
    func showActivityIndicator(on view: UIView, withMessage message: String)
    
    func hideActivityIndicator(from view: UIView)
    
    func showAlert(on view:UIViewController, message: String)
    
    func showToastMessage(on view:UIViewController, message: String)
    
    func showToastMessage(on view:UIViewController, message: String, duration: CGFloat, position: String)
    
    func setImage(for imageView: UIImageView, url: URL?, placeholder: UIImage?, completionBlock: (() -> Void)?)
    
    func removeBranchReferCode()
    
    func showIBSVAlert(withTitle title: String?, msg: String?, confirmTitle: String?, cancelTitle: String?, onCancel:  @escaping () -> Void, onConfirm:  @escaping () -> Void)
    
    func navigateToUserConfirmationScreen(on navigationController: UINavigationController?, isExistingUser: Bool, successBlock: LoginCompletionBlock?)
    
    func navigateToEarn()
    
    func rewardsDataUpdated()
}

extension AuthModuleUIProtocol {
    func setImage(for imageView: UIImageView, url: URL?, placeholder: UIImage?) {
        self.setImage(for: imageView, url: url, placeholder: placeholder, completionBlock: nil)
    }
}

public protocol AuthModuleNetworkProtocol {
    
    func getServer_C() -> String?
    
    func getAuthKey() -> String?
    
    func getUUID() -> String?
    
    func getAppVersion() -> String?
    
    func getAuthSecret() -> String?
    
    func getFlavourDictionary() -> [String: Any]?
    
    func userLoggedInSuccessfully()
    
    func userLoggedOutSuccessfully()
    
    func getServer_Auth() -> String?
    
    func getAmigoServer() -> String?
    
    func getAmigoBasic() -> String?
}

public class AuthDepedencyInjector {

    internal static var uiDelegate: AuthModuleUIProtocol?
    
    internal static var networkDelegate: AuthModuleNetworkProtocol?
    
    internal static var branchReferDictionary: NSDictionary?
    
    internal static var firebaseHandlerDelegate: FirebaseHandlerProtocol.Type?
    
    internal static var firebaseRemoteHandlerDelegate: FirebaseRemoteHelperProtocol.Type?
    
    internal static var AnalyticsDelegate: CommonAnalytisProtocol.Type?
    
    public static func initializeDepedency(uiDelegate: AuthModuleUIProtocol?,
                                           networkDelegate: AuthModuleNetworkProtocol?,
                                           firebaseDelegate: FirebaseHandlerProtocol.Type?,
                                           firebaseRemoteDelegate: FirebaseRemoteHelperProtocol.Type?,
                                           analyticsDelegate: CommonAnalytisProtocol.Type?) {
        self.uiDelegate = uiDelegate
        self.networkDelegate = networkDelegate
        self.AnalyticsDelegate = analyticsDelegate
        self.firebaseHandlerDelegate = firebaseDelegate
    }
    
    public static func injectReferralDictionary(dictionary: NSDictionary?) {
        self.branchReferDictionary = dictionary
    }
    
}

