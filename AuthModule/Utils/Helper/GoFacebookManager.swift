//
//  GoFacebookManager.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

typealias FbCompletionBlock = (Bool, Error?) -> Void
//typealias LoginManagerLoginResultBlock = (LoginManagerLoginResult?, Error?)

class GoFacebookManager {
    
    static let shared: GoFacebookManager = GoFacebookManager()
    
    var permissionArray: [String]
    
    var loginManager: LoginManager?
    
    var isFacebookSessionOpen: Bool {
        return AccessToken.current != nil
    }

    private init() {
        let dictionary = FireBaseHandler.getDictionaryFor(keyPath: .onboarding) //<NITIN> FirebaseConfigKeyOnboarding OBJECTIVE C
        if let permission = dictionary["f_p"] as? String, !permission.isEmpty {
            permissionArray = permission.components(separatedBy: ",")
        } else {
            permissionArray = ["email", "user_mobile_phone"]
        }
    }
    
    func loginToFacebook(completion: @escaping FbCompletionBlock) {
        if AccessToken.current != nil {
            signOutFromFacebook()
        }
        
        loginToFacebook(withPermissions: self.permissionArray) { [weak self] (result, error) in
            
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.handleError(error)
                completion(false, nil)
            } else if let result = result, result.isCancelled {
                completion(false, nil)
            } else {
                completion(true, nil)
            }
        }
        
    }
    
    func loginToFacebook(withPermissions permissions: [String], completion: LoginManagerLoginResultBlock?) {
        
        Profile.enableUpdatesOnAccessTokenChange(true)
        
        if AccessToken.current == nil {
            loginManager = LoginManager()
            loginManager?.logIn(permissions: self.permissionArray, from: nil, handler: completion)
        }
    }
    
    func signOutFromFacebook() {
        loginManager?.logOut()
        AccessToken.current = nil
    }
    
    func handleError(_ error: Error?) {
        AuthCache.shared.setUserDefaltBool(false, forKey: NetworkConstants.kLoginDirectlyViaFacebook)
        AuthAlert.show(withTitle: "Unknown Error", message: "Error. Please try again later.")
    }
    
}
