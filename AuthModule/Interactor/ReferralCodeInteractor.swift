//
//  ReferralCodeInteractor.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit
import NetworkLayerFramework

class ReferralCodeInteractor: BaseInteractor, ReferralCodePresenterToInteractorProtocol {
    
    weak var presenter: ReferralCodeInteractorToPresenterProtocol?
    
    func verifyReferralCode(referralCode:String) {
        
        var parameters = Dictionary<String, String>()
        parameters["referral_code"] = referralCode
        parameters["client_id"] = AuthNetworkUtils.getAuthKey()
        parameters["did"] = AuthNetworkUtils.getUUID()
        parameters["device_id"] = AuthNetworkUtils.getUUID()
        parameters["device_id"] = "true"
        
        Session.service.post(LoginConstants.verifyReferralCodeUrl(), data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { [weak self] (json) in
            
            if let response = LoginVerifyReferralParser().parseJSON(json.dictionaryObject) as? ReferralVerifyData {
                self?.presenter?.verifyReferralSuccessResponse(response: response)
            } else {
                self?.presenter?.verifyReferralRequestFailed(error: nil)
            }
            
        }, failure: { [weak self] (json, error) in
            self?.presenter?.verifyReferralRequestFailed(error: self?.getErrorDataFrom(error: json?.dictionaryObject ?? error))
        })
    }
}


