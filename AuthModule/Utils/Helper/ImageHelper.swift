//
//  ImageHelper.swift
//  AuthModule
//
//  Created by Nitin Chadha on 07/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

extension UIImage {

    static let backButton = ImageHelper.getImage(for: "backArrowNew")
    
    //ReferralCodeValidationViewController
    static let referralHeader = ImageHelper.getImage(for: "referralHeaderImg")
    
    //LoginWelcomeViewController
    static let giftIcon = ImageHelper.getImage(for:"loginReferral")
    static let indianFlag = ImageHelper.getImage(for:"IndiaFlag")
    static let arrowUp = ImageHelper.getImage(for: "loginUpTriangle")
    static let arrowDown = ImageHelper.getImage(for: "loginDownTriangle")
    static let whatsapp = ImageHelper.getImage(for: "loginWhatsApp")
    static let facebook = ImageHelper.getImage(for: "loginFB")
    
    static let loginHeader = ImageHelper.getImage(for: "loginHeaderImage")
    static let mConnectIcon = ImageHelper.getImage(for: "mconnect")
    
    //SignInWithPasswordViewController
    static let passwordHeader = ImageHelper.getImage(for: "passwordImage")
    static let onlineOrder = ImageHelper.getImage(for: "onlineOrder")
    static let passwordHiddenIcon = ImageHelper.getImage(for: "eyeSlashed")
    static let passwordShownIcon = ImageHelper.getImage(for: "view1")
     
    //KeychainViewController
    static let defaultUserIcon = ImageHelper.getImage(for: "icon_personalProfile")
    
    //OTPVerificationViewController
    static let otpHeader = ImageHelper.getImage(for: "otp_image")
    static let editPen = ImageHelper.getImage(for: "otp_edit")
    static let whatsappRound = ImageHelper.getImage(for: "otp_wts_app")
    
    //ForgotPasswordViewController
    static let giLogo = ImageHelper.getImage(for: "goibiboCopy")
    static let goCash = ImageHelper.getImage(for: "goCash_login")
    static let questions = ImageHelper.getImage(for: "icQna")
    static let clickIcon = ImageHelper.getImage(for: "icHand")
    
    //SignUpViewController
    static let errorIcon = ImageHelper.getImage(for: "referralCodeWarning")
    static let tickIcon = ImageHelper.getImage(for: "csCheck")
    
    static let onboardingPic1 = ImageHelper.getImage(for: "getStarted1")
    static let onboardingPic2 = ImageHelper.getImage(for: "getStarted2")
    static let onboardingPic3 = ImageHelper.getImage(for: "getStarted3")
}

class ImageHelper {

    static func setImage(for imageView: UIImageView, url: URL?, placeholder: UIImage?) {
        AuthDepedencyInjector.uiDelegate?.setImage(for: imageView, url: url, placeholder: placeholder, completionBlock: nil)
    }
    
    static func setImage(for imageView: UIImageView, url: URL?, placeholder: UIImage?, completionBlock: (() -> Void)?) {
        AuthDepedencyInjector.uiDelegate?.setImage(for: imageView, url: url, placeholder: placeholder, completionBlock: completionBlock)
    }
    
    static func getImage(for name: String) -> UIImage {
        return UIImage(named: name, in: AuthUtils.bundle, compatibleWith: nil) ?? UIImage()
    }
}

