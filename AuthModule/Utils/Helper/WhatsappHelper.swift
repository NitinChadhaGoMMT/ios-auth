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
    
    func handleToken(token: String?, referralCode: String?, extraKeys: String?) {
        guard let token = token else { return }
        
        self.referralCode = referralCode
        
        if UserDataManager.shared.isLoggedIn {
            
            let phone = UserDataManager.shared.activeUser?.phone ?? Constants.kEmptyString
            var message = FireBaseHandler.getStringFor(keyPath: .whatsappAlreadyLoginAlertMsg, dbPath: .goCoreDatabase) ?? "You are already logged in with <phone>. Do you want to logout?"
            let ctaText = FireBaseHandler.getStringFor(keyPath: .whatsappAlreadyLoginAlertCTA, dbPath: .goCoreDatabase) ?? "Logout"
            message = message.replacingOccurrences(of: "<phone>", with: phone)
            AuthDepedencyInjector.uiDelegate?.showIBSVAlert(withTitle: nil, msg: message, confirmTitle: ctaText, cancelTitle: "Cancel", onCancel: { [weak self] in
                self?.delegate = nil
            }, onConfirm: { [weak self] in
                UserDataManager.shared.logout(type: .user)
                self?.launchLoginWelcomeActivityIfNotLaunched()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(100)) {
                    self?.intiaiteWhatsAppLogin(token: token, referralCode: referralCode, extraKeys: extraKeys)
                }
            })
        }
    }
    
    private func launchLoginWelcomeActivityIfNotLaunched(){
        if self.delegate == nil {
            //<NITIN>
            AuthRouter.shared.createModule()
        }
    }
    
    private func intiaiteWhatsAppLogin(token: String, referralCode:String?, extraKeys:String?) {
        
        //<NITIN> Show Activity Indicator on root VC
        
        //var myActivity = IBSVHUDActivity.show(in: rootVc.view, activityStyle: URL_ACT_STYLE_FULL_SCREEN_BLUR, status: "Logging in with Whatsapp..", ticketType: TICKET_LOGIN)
        //HIDE AFTER API
        AuthService.requestToLoginWithWhatsApp(token, referralCode: referralCode, extraKey: extraKeys, success: { [weak self](data) in
            if let otpverifiedData = data as? OtpVerifiedData {
                if self?.delegate == nil {
                    AuthDepedencyInjector.uiDelegate?.authLoginCompletion(isUserLoggedIn: true, error: nil)
                } else{
                    self?.delegate?.loginSuccessful(verifiedData: otpverifiedData, extraKeys:extraKeys)
                }
            } else{
                self?.delegate?.loginFailed(error: nil)
            }
        }) { [weak self] (error) in
            self?.delegate?.loginFailed(error: error)
        }
    }
}
