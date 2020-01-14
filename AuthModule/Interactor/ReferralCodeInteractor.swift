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
        parameters[Keys.referralCode] = referralCode
        parameters[Keys.clientId] = AuthNetworkUtils.getAuthKey()
        parameters[Keys.did] = AuthNetworkUtils.getUUID()
        parameters[Keys.deviceId] = AuthNetworkUtils.getUUID()
        parameters[Keys.deviceId] = "true"
        
        Session.service.post(URLBuilder.verifyReferralCodeUrl, data: appendDefaultParameters(params: parameters), header: nil, encoding: URLEncoding.httpBody, success: { [weak self] (json) in
            
            if let response: ReferralVerifyData = self?.parseResponse(dictionary: json.dictionaryObject) {
                self?.presenter?.verifyReferralSuccessResponse(response: response)
            } else {
                self?.presenter?.verifyReferralRequestFailed(error: nil)
            }
            
        }, failure: { [weak self] (json, error) in
            self?.presenter?.verifyReferralRequestFailed(error: self?.getErrorDataFrom(error: json?.dictionaryObject ?? error))
        })
    }
    
    func parseResponse(dictionary: [String: Any]?) -> ReferralVerifyData? {
        return LoginVerifyReferralParser().parseJSON(dictionary) as? ReferralVerifyData
    }
}


