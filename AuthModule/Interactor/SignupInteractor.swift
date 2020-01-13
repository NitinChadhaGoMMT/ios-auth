//
//  SignupInteractor.swift
//  AuthModule
//
//  Created by Nitin Chadha on 11/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import NetworkLayerFramework

class SignupInteractor: BaseInteractor, SignUpPresenterToInteractorProtocol {
    
    weak var presenter: SignUpInteractorToPresenterProtocol?
    
    func requestToSignUp(_ fullName:String, mobileKey:String, referalCode:String, isWhatsAppFlow:Bool, extraKey:String?) {
        var params = Dictionary<String, Any>()
        
        
        params["mobile_key"] = mobileKey
        params["fullname"] = fullName
        
        
        if !referalCode.isEmpty {
            params["referral_code"] = referalCode
        }

        if isWhatsAppFlow {
            params["medium"] = "whatsapp"
        }
        if let extKeys = extraKey {
            params["extra_keys"] = extKeys
        }
        if let authParams = AuthCache.shared.getUserDefaltObject(forKey: "auth_params_string") {
            params["auth_params"] = authParams
        }
        
        params["client_id"] = AuthNetworkUtils.getAuthKey()
        params["did"] = AuthNetworkUtils.getUUID()
        params["device_id"] = AuthNetworkUtils.getUUID()
        
        Session.service.post(LoginConstants.createAccountUrl(), data: appendDefaultParameters(params: params), header: nil, encoding: URLEncoding.httpBody, success: {
            [weak self] (json) in

            self?.presenter?.signUpRequestSuccess(otpVerifiedData: LoginOTPVerifyParser().parseJSON(json.dictionaryObject) as? OtpVerifiedData)
            
        }, failure: { [weak self] (json, error) in
            self?.presenter?.signUpRequestFailed(error: self?.getErrorDataFrom(error: error))
        })
    }
    
}
