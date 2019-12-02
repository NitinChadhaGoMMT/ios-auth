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
    
    func hideActivityIndicator(from view: UIView)
    
    func showAlert(on view:UIViewController, message: String)
    
}

public protocol AuthModuleNetworkProtocol {
    
    func getServer_C() -> String?
    
    func getAuthKey() -> String?
    
    func getUUID() -> String? 
}

public class AuthDepedencyInjector {

    internal static var uiDelegate: AuthModuleUIProtocol?
    
    internal static var networkDelegate: AuthModuleNetworkProtocol?
    
    internal static var branchReferDictionary: NSDictionary?
    
    public static func initializeDepedency(uiDelegate: AuthModuleUIProtocol?, networkDelegate: AuthModuleNetworkProtocol?) {
        self.uiDelegate = uiDelegate
        self.networkDelegate = networkDelegate
    }
    
    public static func injectReferralDictionary(dictionary: NSDictionary?) {
        self.branchReferDictionary = dictionary
    }
    
}

public class ActivityIndicator {
    static func show(on view: UIView) {
        AuthDepedencyInjector.uiDelegate?.showActivityIndicator(on: view)
    }
    
    static func hide(on view: UIView) {
        AuthDepedencyInjector.uiDelegate?.hideActivityIndicator(from: view)
    }
}
