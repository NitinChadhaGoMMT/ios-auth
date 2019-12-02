//
//  LoginWrapper.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class LoginWrapper {

    static func hashAuthString(for params: Dictionary<String, Any>) -> String {
        return hashAuthString(ForDictionary: params, withSalt: AuthNetworkUtils.syncMD())
    }
    
    private static func hashAuthString(ForDictionary dictionary: Dictionary<String, Any>, withSalt salt: String) -> String {
        let sortedKeys = dictionary.keys.sorted()
        var hash1 = sortedKeys.reduce("") { $0 + "\(dictionary[$1]!)|" }
        hash1 = hash1 + salt
        return CommonUtils.md5Hash(hash1)
        //<NITIN>return Utils.md5Hash(hash1)
    }
    
}
