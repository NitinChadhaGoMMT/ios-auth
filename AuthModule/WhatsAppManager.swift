//
//  WhatsAppHelper.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class FireBaseHandler {
    
    static let FirebaseDelegate = AuthDepedencyInjector.firebaseHandlerDelegate
    
    static func getStringFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> String? {
        return FirebaseDelegate?.getStringFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func getBoolFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> Bool? {
        return FirebaseDelegate?.getBoolFor(keyPath: keyPath, dbPath: dbPath)
    }
    
    static func getDictionaryFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> Dictionary<AnyHashable, Any> {
        return [:]
    }
    
    static func getArrayFor(keyPath: FirebaseConfigKey, dbPath: FirebaseDatabaseKey = .goConfigDatabase) -> [Any] {
        
        if keyPath == .onboardingWelcomeTutorial {
            return [
              ["bgImage":"onboardingBgImg",
              "logoImage":"rewardsLogo",
              "subtitle1":"Get benefits at each level ",
              "subtitle2":"like free meals, room upgrade and more",
              "title" : "Signup Now to"
            ], [
              "bgCornerImage" : "onboardingRupee",
              "subtitle1" : "Earn Rs.100 goCash+ instantly",
              "subtitle2" : "and use 100% goCash+ on your bookings",
              "title" : "Signup Now to",
              "type" : 1
         ], [
              "bgCornerImage" : "onboardingFriends",
              "subtitle1" : "Earn when your friends travel",
              "subtitle2" : "and plan your next dream vacation together",
              "title" : "Signup Now to"
            ], [
              "bgCornerImage" : "onboardingQnA",
              "subtitle1" : "Get answers to your questions",
              "subtitle2" : "from real users in the Goibibo travel community",
              "title" : "Signup Now to"
            ]]
        }
        return []
    }
}

protocol WhatsappHelperDelegate: class {
    func loginSuccessful(verifiedData: OtpVerifiedData?, extraKeys:String?)
    func loginFailed(error: Any?)
}

class WhatsAppManager {
    
    static let shared = WhatsAppManager()
    
    var referralCode: String?
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
        return false
    }
    
    func isWhatsAppLoginEnabled() -> Bool {
        
        guard canOpenWhatsApp() else {
            return false
        }
        
        let whatsAppEnabled = FireBaseHandler.getBoolFor(keyPath: .whatsapp_login_msg, dbPath: .goCoreDatabase)
        if(whatsAppEnabled == true) {
            //let status = FirebaseRemoteHelper.sharedInstance.getRemoteFunctionBoolValue(forkey: "remote_whatsapp_enabled")
            //return status
            return false
        }
        
        return false
    }
    
    func getWhatsappUrl(referralCode:String?) -> URL? {
        
        let phone = FireBaseHandler.getStringFor(keyPath: .whatsapp_login_phone, dbPath: .goCoreDatabase)
        var text = ""
        if referralCode == nil || referralCode!.count == 0{
            text = FireBaseHandler.getStringFor(keyPath: .whatsapp_login_text, dbPath: .goCoreDatabase) ?? ""
        }
        else{
            text = FireBaseHandler.getStringFor(keyPath: .whatsappLoginTextReferral, dbPath: .goCoreDatabase) ?? ""
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
