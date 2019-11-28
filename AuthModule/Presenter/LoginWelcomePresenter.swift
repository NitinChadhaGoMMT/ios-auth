//
//  LoginWelcomePresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

enum LoginCellType {
    case welcomeLogo, newUserDetails, skipNow, orLabelCell, fbloginCell, whatsappCell
    
    var height: CGFloat {
        switch self {
        case .newUserDetails:
            return LoginNewUserDetailsCell.height
            
        case .orLabelCell:
            return LoginOrTableCell.height
            
        case .fbloginCell:
            return LoginFBSingupTableCell.height
            
        case .skipNow:
            return LoginSkipNowTableCell.height
            
        default:
            return 44
        }
    }
}

class LoginWelcomePresenter {

    weak var view: LoginWelcomeViewController!
    
    var interactor: LoginWelcomeInteractor!
    
    var dataSource: [[LoginCellType]]
    
    var isFbSignup: Bool = false
    var referralCode: String?
    var branchDictionary: NSDictionary?
    
    init() {
        if WhatsAppManager.shared.isWhatsAppLoginEnabled() {
            dataSource =  [[.welcomeLogo], [.newUserDetails,.orLabelCell, .whatsappCell], [.skipNow]]
        } else {
            dataSource = [[.welcomeLogo], [.newUserDetails,.orLabelCell,.fbloginCell], [.skipNow]]
        }
    }
    
    func checkMobileValidity(mobileNumber: String?) -> Bool {
        return AuthUtils.isValidPhoneNumber(mobileNumber)
    }
}
