//
//  WhatsappHelper.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol WhatsappHelperDelegate: class {
    func loginSuccessful(verifiedData: OtpVerifiedData?, extraKeys:String?)
    func loginFailed(error: Any?)
}

class WhatsappHelper {

    static let shared = WhatsappHelper()
    
    weak var delegate: WhatsappHelperDelegate?
    
    var referralCode: String?
    
    private init() { }
    
    func handleToken(token: String?, referralCode: String?, extraKeys: String?, navigationController: UINavigationController?) {
        guard let token = token else { return }
        
        self.referralCode = referralCode
        
        if UserDataManager.shared.isLoggedIn {
            
            let phone = UserDataManager.shared.activeUser?.phone ?? .kEmptyString
            var message = FireBaseHandler.getStringFor(keyPath: .whatsappAlreadyLoginAlertMsg, dbPath: .goCoreDatabase) ?? "You are already logged in with <phone>. Do you want to logout?"
            let ctaText = FireBaseHandler.getStringFor(keyPath: .whatsappAlreadyLoginAlertCTA, dbPath: .goCoreDatabase) ?? "Logout"
            message = message.replacingOccurrences(of: "<phone>", with: phone)
            AuthDepedencyInjector.uiDelegate?.showIBSVAlert(withTitle: nil, msg: message, confirmTitle: ctaText, cancelTitle: "Cancel", onCancel: { [weak self] in
                self?.delegate = nil
            }, onConfirm: { [weak self] in
                UserDataManager.shared.logout(type: .user)
                self?.launchLoginWelcomeActivityIfNotLaunched(navigationController: navigationController)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(100)) {
                    self?.intiaiteWhatsAppLogin(token: token, referralCode: referralCode, extraKeys: extraKeys, navigationController: navigationController)
                }
            })
        } else{
            self.launchLoginWelcomeActivityIfNotLaunched(navigationController: navigationController)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(100)) {
                self.intiaiteWhatsAppLogin(token: token, referralCode: referralCode, extraKeys: extraKeys, navigationController: navigationController)
            }
        }
    }
    
    private func launchLoginWelcomeActivityIfNotLaunched(navigationController: UINavigationController?){
        if self.delegate == nil {
            AuthRouter.shared.invokeLoginFlow(onNavigationStack: navigationController)
        }
    }
    
    private func intiaiteWhatsAppLogin(token: String, referralCode:String?, extraKeys:String?, navigationController: UINavigationController?) {
        
        guard let navigationController = navigationController else { return }
        
        guard let view = navigationController.visibleViewController?.view else {
            return
        }
        
        ActivityIndicator.show(on: view, withMessage: "Logging in with Whatsapp..")
        
        AuthService.requestToLoginWithWhatsApp(token, referralCode: referralCode, extraKey: extraKeys, success: { [weak self](data) in
            ActivityIndicator.hide(on: view)
            if let otpverifiedData = data as? OtpVerifiedData {
                if self?.delegate == nil {
                    AuthDepedencyInjector.uiDelegate?.userLoggedInSuccessfullyViaWhatsApp()
                } else{
                    self?.delegate?.loginSuccessful(verifiedData: otpverifiedData, extraKeys:extraKeys)
                }
            } else{
                if self?.delegate == nil {
                    AuthDepedencyInjector.uiDelegate?.userLoginFailedViaWhatsApp(error: nil)
                } else{
                    self?.delegate?.loginFailed(error: nil)
                }
            }
        }) { [weak self] (error) in
            ActivityIndicator.hide(on: view)
            if self?.delegate == nil {
                AuthDepedencyInjector.uiDelegate?.userLoginFailedViaWhatsApp(error: nil)
            } else {
                self?.delegate?.loginFailed(error: error)
            }
        }
    }
}
