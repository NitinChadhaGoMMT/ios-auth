//
//  UserConfirmationInteractor.swift
//  AuthModule
//
//  Created by Nitin Chadha on 02/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import Foundation
import NetworkLayerFramework

class UserConfirmationInteractor {
    
    //weak var presenter: UserConfirmationPresenter!
    
    func getReverseProfiles() {
        AuthService.getReverseProfiles("", success: { [weak self] (data) in
            
        }) { [weak self] (error) in
            
        }
    }

}
