//
//  AuthDataProvider.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

public class AuthDataProvider {
    
    public static var userId: String? {
        return UserDataManager.shared.activeUser?.userid
    }
    
    public static var hasPassword: Bool {
        return UserDataManager.shared.activeUser?.hasPassword?.boolValue ?? false
    }
    
    public static var isVerified: Bool {
        return UserDataManager.shared.activeUser?.isVerified?.boolValue ?? false
    }
    
    public static var email: String? {
        return UserDataManager.shared.activeUser?.email
    }
    
    public static var firstName: String? {
        return UserDataManager.shared.activeUser?.firstname
    }
    
    public static var isUserLoggedIn: Bool {
        return UserDataManager.shared.isLoggedIn
    }
    
    public static var accessToken: String? {
        return AuthCache.shared.getUserDefaltObject(forKey: "access_token") as? String
    }
    
    public static func logoutUser() {
        UserDataManager.shared.logout(type: .user)
    }
    
    public class func goServiceUserInfoLogin(_ sender: UIViewController?, pop: Bool, finishedVC: UIViewController?, onError: @escaping (Any?) -> Void, onFinished: @escaping (Any?) -> Void) {
        LoginWrapper.goServiceUserInfoLogin(sender, pop: pop, finishedVC: finishedVC, onError: onError, onFinished: onFinished)
    }
    
}
