//
//  BaseInteractor.swift
//  AuthModule
//
//  Created by Nitin Chadha on 11/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class BaseInteractor: InteractorBaseProtocol {

    func checkForMobileConnectAPI(completionBlock: @escaping (MconnectData?) -> ()){
        
        let dict = FireBaseHandler.getDictionaryFor(keyPath: .onboarding)
        var mcStatus = false
        if let status = dict["mc_status3"] as? Bool {
           mcStatus = status
        }
        if AuthUtils.isMobileNetworkConnected() && mcStatus {
            
            AuthService.validateForMconnect(success: { (responseData) in
                completionBlock(responseData as? MconnectData)
            }) { (error) in
                completionBlock(nil)
            }
        } else {
            completionBlock(nil)
        }
    }
    
    func verifymConnectDataWithMobileNo(_ mobileNo: String){ }
        /*
        self.view.endEditing(true)
        let service = MconnectServices()
        service.verifyMobileWithMconnectForController(self, withMobileNo: mobileNo, mconnectData: self.mconnectData!, isFBSignUp:self.isFbSignup, referralCode:self.referralCode, onError: { [weak self](error) in
            self?.handleMConnectFailure(mobileNo: mobileNo)
        }) {[weak self] (responseData) in
            self?.handleMConnectSuccessData(responseData, mobileNo:mobileNo)
        }
    }*/
    
}
