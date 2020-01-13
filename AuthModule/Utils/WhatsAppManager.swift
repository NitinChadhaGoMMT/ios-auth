//
//  WhatsAppHelper.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class WhatsAppManager {
    
    static let shared = WhatsAppManager()
    
    var referralCode: String = ""
    weak var delegate: WhatsappHelperDelegate?
    
    //<NITIN>  CHECK KEYPATH
    func canOpenWhatsApp() -> Bool {
        let phone = FireBaseHandler.getStringFor(keyPath: .whatsapp_login_msg, dbPath: .goCoreDatabase)
        let abid = FireBaseHandler.getStringFor(keyPath: .whatsapp_login_msg, dbPath: .goCoreDatabase)
        let urlWhats = "whatsapp://send?phone=\(phone)&abid=\(abid)&text="
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    return true
                }
            }
        }
        //<NITIN>return false
        return true
    }
    
    func isWhatsAppLoginEnabled() -> Bool {
        //<NITIN> remove below line
        return true
        
        guard canOpenWhatsApp() else {
            return false
        }
        
        let whatsAppEnabled = FireBaseHandler.getBoolFor(keyPath: .whatsapp_login_msg, dbPath: .goCoreDatabase)
        if(whatsAppEnabled == true) {
            return AuthDepedencyInjector.firebaseRemoteHandlerDelegate?.getRemoteFunctionBoolValueWithForkey(forKey: "remote_whatsapp_enabled") ?? false
        }
        
        return false
    }
    
    func getWhatsappUrl(referralCode:String?) -> URL? {
        
        var phone = FireBaseHandler.getStringFor(keyPath: .whatsapp_login_phone, dbPath: .goCoreDatabase) ?? "+919213025552"
        var text = ""
        if referralCode == nil || referralCode!.count == 0{
            text = FireBaseHandler.getStringFor(keyPath: .whatsapp_login_text, dbPath: .goCoreDatabase) ?? "Sign me into Goibibo App"
        }
        else{
            text = FireBaseHandler.getStringFor(keyPath: .whatsappLoginTextReferral, dbPath: .goCoreDatabase) ?? "Sign me into Goibibo App with invite code: <rcode>"
            if text.contains("<rcode>") {
                text = text.replacingOccurrences(of: "<rcode>", with: referralCode ?? "")
            }
        }
        
        
        
        let urlWhats = "https://api.whatsapp.com/send?phone=\(phone)&text=\(text)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    return whatsappURL
                }
            }
        }
        return nil
    }
    
    func loginWithWhatsapp(referralCode:String?) {
        if let url = getWhatsappUrl(referralCode: referralCode) {
            UIApplication.shared.openURL(url)
        }
    }
    
    func setWhatsappOptInStatusPostLogin(status: Bool) { //<NITIN>
        
    }
}
