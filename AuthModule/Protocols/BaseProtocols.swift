//
//  BaseProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 19/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

protocol PresenterBaseProtocol: class {
    
    var isFbSignup: Bool { get set }
    
    var isWhatsAppLogin: Bool { get set }
    
    var isverifyMethodOtp:Bool { get set }
    
    var referralCode: String? { get set }
    
    var userVerificationData: OtpVerifiedData? { get set }
    
}

protocol InteractorBaseProtocol: class {
    
    func checkForMobileConnectAPI(completionBlock: @escaping (MconnectData?) -> ())
    
    func verifymConnectDataWithMobileNo(_ mobileNo: String)
}

protocol LoginBaseProtocol: class {
    
    var baseNavigationController: UINavigationController? { get }
    
    var mconnectData: MconnectData? { get }
    
    func verifymConnectDataWithMobileNo(_ mobileNo: String, isFbSignup: Bool, referralCode: String)
    
    func showActivityIndicator()
    
    func hideActivityIndicator()
    
    func setMConnectData(data: MconnectData)
    
    func push(screen: UIViewController)
    
    func present(screen: UIViewController)
    
    func dismiss()
    
    func showError(_ errorData:Any?)
    
    func userSuccessfullyLoggedIn(verificationData: OtpVerifiedData?)
    
    func logInSuccessfully()
    
    func signUpSuccessfully()
}
