//
//  AuthDataProvider.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

public class AuthDataProvider {
    
    public static var isUserLoggedIn: Bool {
        return UserDataManager.shared.isLoggedIn
    }
    
    public static func logoutUser() {
        UserDataManager.shared.logout(type: .user)
    }
}
