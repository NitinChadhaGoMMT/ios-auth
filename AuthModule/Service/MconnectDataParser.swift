//
//  MconnectDataParser.swift
//  AuthModule
//
//  Created by Nitin Chadha on 11/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import Foundation

class MconnectData: NSObject {
    var authUrl: String?
    var message: String?
    var operatorName: String?
    var mConnectPublicKey: String?
    var xData:String?
    var isSuccess: Bool = false
}

class MconnectVerifiedData: NSObject {
    var mobileVerifiedData: MobileVerifiedData?
    var otpVerifiedData: OtpVerifiedData?
}

class MconnectDataParser: LoginParser {

    override func parseJSON(_ json: Any?) -> Any?  {
        
        guard let response = json as? Dictionary<String, Any> else {
            
            return nil;
        }
        let mconnectData = MconnectData()
        mconnectData.isSuccess = response["success"] as! Bool
        mconnectData.authUrl = response["authUrl"] as? String
        mconnectData.message = response["message"] as? String
        mconnectData.operatorName = response["operatorName"] as? String
        mconnectData.mConnectPublicKey = response["MOBILE_CONNECT_PUBLIC_KEY"] as? String
        mconnectData.xData = response["XDATA"] as? String
        return mconnectData;
    }
}

class MconnectVerifiedDataParser: LoginParser {
    
    override func parseJSON(_ json: Any?) -> Any?  {
        
        guard let response = json as? Dictionary<String, Any> else {
            return nil;
        }
        
        let mconnectData = MconnectVerifiedData()

        // On basis of nonce decide, which type of data has come
        let nonce = response["nonce"] as? String
        if nonce != nil || response["send_otp"] != nil {
            let mobileVerifyParser = LoginMobileVerifyParser()
            mconnectData.mobileVerifiedData = mobileVerifyParser.parseJSON(response) as? MobileVerifiedData
        }
        else {
            let otpVerifyParser = LoginOTPVerifyParser()
            mconnectData.otpVerifiedData = otpVerifyParser.parseJSON(response) as? OtpVerifiedData
        }
        return mconnectData;
    }
}
