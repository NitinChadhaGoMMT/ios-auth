//
//  KeychainLoginHandler.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import CommonCrypto

class KeychainLoginHandler {
    
    static let shared = KeychainLoginHandler()
    
    let showLoginDataKey = "showLoginData"

    func getDeviceId() -> String? {
        return KeychainWrapper.standard.string(forKey: "device_id")
    }
    
    func setDeviceId(){
        KeychainWrapper.standard.set(AuthNetworkUtils.getUUID(), forKey: "device_id")
    }
    
    func shouldPresentKeyChainLoginScreen() -> Bool{
        let isScreenShownEarlier = AuthCache.shared.getUserDefaltBool(forKey: showLoginDataKey) ?? false
        return !UserDataManager.shared.isLoggedIn && !isScreenShownEarlier  && getAllUsersInfo().keys.count > 0 && ( FireBaseHandler.getBoolFor(keyPath: FirebaseConfigKey.KeychainLogInEnabled) ?? false )
    }
    
    func presentKeyChainLogin(sender: LoginBaseViewController){
        if self.shouldPresentKeyChainLoginScreen(){
            if let vc: KeyChainLoginViewController = AuthRouter.shared.presentKeychainLoginViewController() as? KeyChainLoginViewController {
                sender.presentWithCurrentContext(vc: vc)
            }
        }
    }
    
    func getAllUsersInfo() -> [String:Any]{
        return KeychainWrapper.standard.dictionary(forKey: "userInfo")
    }
    
    func saveCurrentUser() {
        if UserDataManager.shared.isLoggedIn && FireBaseHandler.getBoolFor(keyPath: FirebaseConfigKey.KeychainLogInEnabled) == true {
            var data = self.getAllUsersInfo()
            let email = UserDataManager.shared.activeUser?.email ?? ""
            let phone = UserDataManager.shared.activeUser?.phone ?? ""
            let profilePicUrl = UserDataManager.shared.activeUser?.imageURL ?? ""
            let firstName = UserDataManager.shared.activeUser?.firstname ?? ""
            let secondName = UserDataManager.shared.activeUser?.lastname ?? ""
            let refreshToken = AuthCache.shared.getUserDefaltObject(forKey: Keys.refreshToken) ?? ""
            let userId = UserDataManager.shared.activeUser?.userid ?? ""
            if AuthUtils.isEmptyString(refreshToken) == false{
                let userData = ["name": firstName + " " + secondName ,"email":email,"phone":phone,"refreshToken":refreshToken,"profilePic":profilePicUrl ,"userId":userId,"timeStamp":Int(Date().timeIntervalSince1970)]
                if let userId = UserDataManager.shared.activeUser?.userid{
                    data = [userId :userData]
                    self.setUserData(data:data)
                    self.setDeviceId()
                }
            }
        }
    }
    
    private func setUserData(data:[String:Any]){
        KeychainWrapper.standard.set(data, forKey: "userInfo")
    }
    
    func deleteUser() {
        self.setUserData(data:[String:Any]())
    }
    
    func apiError(controller: LoginBaseViewController){
        ActivityIndicator.hide(on: controller.view)
        AuthCache.shared.setUserDefaltObject(nil, forKey: Keys.refreshToken)
        AuthAlert.showErrorAlert(view: controller, message: "Some error occured!")
        //<NITIN>
        /*IBSVBlockAlert.show(withMsg: "Some error occured!") {() in
            controller.dismiss(animated: true, completion: nil)
        }*/
        
        
    }
    
     func startLogInFLow(userid:String, sender:LoginBaseViewController){
        guard AuthUtils.isMobileNetworkConnected() == true else {
            AuthAlert.noInternetAlert()
            return
        }
        
        if let refreshToken = getRefreshToken(forUserId: userid) {
            ActivityIndicator.show(on: sender.view, withMessage: "Loading...")
            AuthCache.shared.setUserDefaltObject(refreshToken, forKey: Keys.refreshToken)
            
            AuthService.requestLoginWithRefreshAccessToken(successBlock: { [weak self] in
                ActivityIndicator.hide(on: sender.view)
                LoginWrapper.goServiceUserInfoLogin(sender, pop: false, finishedVC: nil, onError: { [weak self](error) in
                    self?.apiError(controller: sender)
                }) { (data) in
                    ActivityIndicator.hide(on: sender.view)
                    sender.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(Notification(name: Notification.chainUpdate))
                }
            }, errorBlock: { [weak self] in
                self?.apiError(controller: sender)
            })
        } else {
            self.apiError(controller: sender)
        }
    }
    
    func getRefreshToken(forUserId userId:String) -> String? {
        let userData = self.getAllUsersInfo()
        if let data = userData[userId] as? [String:Any] {
            if let refreshToken = data["refreshToken"] as? String{
                return refreshToken
            }
        }
        return nil
    }
}
