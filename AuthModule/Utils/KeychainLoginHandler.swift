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
        KeychainWrapper.standard.set("Utils.deviceUUID()", forKey: "device_id")
    }
    
    func shouldPresentKeyChainLoginScreen() -> Bool{
        let isScreenShownEarlier = AuthCache.shared.getUserDefaltBool(forKey: showLoginDataKey) ?? false
        return !UserDataManager.shared.isLoggedIn && !isScreenShownEarlier && getAllUsersInfo().keys.count > 0 && ( FireBaseHandler.getBoolFor(keyPath: FirebaseConfigKey.KeychainLogInEnabled) ?? true )
        //<NITIN> change last true
    }
    
    func presentKeyChainLogin(sender: LoginBaseViewController){
        if self.shouldPresentKeyChainLoginScreen(){
            if let vc: KeyChainLoginViewController = AuthRouter.shared.presentKeychainLoginViewController() as? KeyChainLoginViewController {
                sender.presentWithCurrentContext(vc: vc)
            }
        }
    }
    
    func getAllUsersInfo() -> [String:Any]{
        //<NITIN>return FireBaseHandler.getBoolFor(keyPath: FirebaseConfigKey.KeychainLogInEnabled) == true ? KeychainWrapper.standard.dictionary(forKey: "userInfo") : [String:Any]()
        return KeychainWrapper.standard.dictionary(forKey: "userInfo") ?? [String:Any]()
        /*return ["16342807": ["phone": "7838387938", "userId": "16342807", "refreshToken": "4e31d6f4d4c0d81c14c4db03b9ba6d068f308ce6", "email": "nitinchadha16@gmail.com", "profilePic": "https://s3.ap-south-1.amazonaws.com/auth-public-images/16342807_e1f75345-7276-471e-96ab-f8efe044943d.jpeg", "timeStamp": "1576755762", "name": "Nitin Chadha"]]*/
    }
    
    func saveCurrentUser() {
        
        if UserDataManager.shared.isLoggedIn && FireBaseHandler.getBoolFor(keyPath: FirebaseConfigKey.KeychainLogInEnabled) == true{
            var data = self.getAllUsersInfo()
            let email = UserDataManager.shared.activeUser?.email ?? ""
            let phone = UserDataManager.shared.activeUser?.phone ?? ""
            let profilePicUrl = UserDataManager.shared.activeUser?.imageURL ?? ""
            let firstName = UserDataManager.shared.activeUser?.firstname ?? ""
            let secondName = UserDataManager.shared.activeUser?.lastname ?? ""
            let refreshToken = AuthCache.shared.getUserDefaltObject(forKey: "refresh_token") ?? ""
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
}
