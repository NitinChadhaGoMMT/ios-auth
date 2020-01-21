//
//  AuthNetworkUtils.swift
//  AuthModule
//
//  Created by Nitin Chadha on 09/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import Foundation

struct AuthNetworkUtils {
    
    static func getServer_Auth() -> String {
        return AuthDepedencyInjector.networkDelegate?.getServer_Auth() ?? NetworkConstants.authServer
    }
    
    static func getServer_C() -> String {
        return AuthDepedencyInjector.networkDelegate?.getServer_C() ?? NetworkConstants.server_C
    }
    
    static func syncMD() -> String {
        return "78IUdfh@m^xlpwq)$a0#";
    }
    
    static func getAuthKey() -> String {
        return AuthDepedencyInjector.networkDelegate?.getAuthKey() ?? NetworkConstants.authKey
    }
    
    static func getAuthSecret() -> String {
        return AuthDepedencyInjector.networkDelegate?.getAuthSecret() ?? NetworkConstants.authSecret
    }
    
    static func getUUID() -> String {
        return AuthDepedencyInjector.networkDelegate?.getUUID() ?? UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
}
