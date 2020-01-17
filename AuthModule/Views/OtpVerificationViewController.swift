//
//  OtpVerificationViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class OtpVerificationViewController: LoginBaseViewController {
    
    @IBOutlet weak var scrollViewBottomConstraint : NSLayoutConstraint!
    @IBOutlet weak var mobileLogoImageView: UIImageView!
    @IBOutlet weak var whatsAppIconButton: UIButton!
    @IBOutlet weak var editIconButton: UIButton!
    @IBOutlet weak var otpScrollView: UIScrollView!
    @IBOutlet weak var otpMsgLabel2: UILabel!
    @IBOutlet weak var otpMsgLabel3: UILabel!
    @IBOutlet weak var otpBgView: UIView!
    @IBOutlet weak var continueLabel: UILabel!
    @IBOutlet  var otpTextFieldsOutletCollection: [UITextField]!
    @IBOutlet weak var optionalOtpView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var dashedLineView1: UIView!
    @IBOutlet weak var dashedLineView2: UIView!
    @IBOutlet weak var resendButtonConstraint : NSLayoutConstraint!
    
    var textFieldsIndexes:[UITextField:Int] = [:]
    var totalTime:Int = 30
    var countDownTimer: Timer?
    
    var isContinueEnabled: Bool = false {
        didSet {
            continueLabel.isUserInteractionEnabled = self.isContinueEnabled
            continueLabel.backgroundColor = self.isContinueEnabled ? .orange : .lightGray
            continueLabel.textColor = self.isContinueEnabled ? UIColor.white : UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        }
    }
    
    var isResendEnabled: Bool = false {
        didSet {
            self.resendButton.isEnabled = isResendEnabled
            self.resendButton.isUserInteractionEnabled = isResendEnabled
            self.timerLabel.isHidden = isResendEnabled
            self.resendButtonConstraint.constant = isResendEnabled ?  0 : -20
            self.resendButton.setTitle( isResendEnabled ? "Resend OTP" : "Resend OTP in", for: .normal)
            self.resendButton.setTitleColor( isResendEnabled ? UIColor.customBlue : UIColor.gray , for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    var presenter: OTPVerificationViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserInterface()
        startTimer()
    }
    
    func configureUserInterface() {
        
        editIconButton.setBackgroundImage(.editPen, for: .normal)
        whatsAppIconButton.setImage(.whatsappRound, for: .normal)
        mobileLogoImageView.image = .otpHeader
        
        otpTextFieldsOutletCollection.forEach {
            $0.layer.cornerRadius = 27
            $0.layer.masksToBounds = true
        }
        
        continueLabel.makeCornerRadiusWithValue(5.0, borderColor: UIColor.clear)
        
        for index in 0 ..< otpTextFieldsOutletCollection.count {
            textFieldsIndexes[otpTextFieldsOutletCollection[index]] = index
            otpTextFieldsOutletCollection[index].showAccessoryViewWithButtonTitle("Dismiss")
        }
        
        otpTextFieldsOutletCollection[0].becomeFirstResponder()
        
        
        otpMsgLabel3.text = presenter?.mobileNumber ?? "-"
        continueLabel.addTapGestureWithAction(#selector(continueTapped), target: self)
        continueLabel.makeCornerRadiusWithValue(5.0, borderColor: UIColor.clear)
        timerLabel.textColor = UIColor.gray
        optionalOtpView.isHidden =  true
        isContinueEnabled = false
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        if presenter?.shouldShowWhatsappLogin() ?? false {
            enableWhatsAppLogin()
        }
        
        if let customFont = UIFont(name: "Quicksand-Bold", size: 18){
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : customFont]
        }
        
        if var header = FireBaseHandler.getStringFor(keyPath: .otpHeader, dbPath: .goAuthDatabase) {
            header = header.replacingOccurrences(of: "\\n", with: "\n")
            otpMsgLabel2.attributedText = NSAttributedString(string:header)
        }
    }
    
    fileprivate func prepareOtpTextFiled() {
        
        for index in 0 ..< otpTextFieldsOutletCollection.count {
            otpTextFieldsOutletCollection[index].text = ""
        }
        
        otpTextFieldsOutletCollection[0].becomeFirstResponder()
    }
    
    
    @objc func continueTapped(sender: AnyObject) {
        let otpFromTextFiled = self.getOtpFromTextFields()
        self.presenter?.logGAClickEvent(for: "verify")
        self.view.endEditing(true)
        LoginGAPManager.logTappedEvent(with: .signInContinue, forController: self)
        
        if self.scrollViewBottomConstraint.constant != 0 {
            self.scrollViewBottomConstraint.constant = 0
            self.otpScrollView.contentOffset = CGPoint(x: 0.0, y: -64.0)
        }
        
        ActivityIndicator.show(on: self.view)
        self.presenter?.verifyOTP(withOtp: otpFromTextFiled)
    }
    
    fileprivate func enableWhatsAppLogin() {
        if WhatsAppManager.shared.isWhatsAppLoginEnabled() {
            self.dashedLineView1.drawDottedLine(start: CGPoint(x: dashedLineView1.bounds.minX, y: dashedLineView1.bounds.minY), end: CGPoint(x: dashedLineView1.bounds.maxX, y: dashedLineView1.bounds.minY))
            self.dashedLineView2.drawDottedLine(start: CGPoint(x: dashedLineView2.bounds.minX, y: dashedLineView2.bounds.minY), end: CGPoint(x: dashedLineView2.bounds.maxX, y: dashedLineView2.bounds.minY))
            self.optionalOtpView.isHidden =  false
        }
    }
    
    fileprivate func getOtpFromTextFields() -> String {
        var otpFromTextFiled = ""
        
        for index in 0 ..< otpTextFieldsOutletCollection.count {
            otpFromTextFiled = otpFromTextFiled + (otpTextFieldsOutletCollection[index].text ?? "")
        }
        return otpFromTextFiled
    }
    
    @IBAction func editNumberAction(_ sender: Any) {
        if let navStack = self.navigationController?.viewControllers.reversed() {
            for vc in navStack{
                if vc is MobileVerificationViewController {
                    _ = self.navigationController?.popToViewController(vc, animated: true)
                    break
                }
                else if vc is LoginWelcomeViewController {
                    _ = self.navigationController?.popToViewController(vc, animated: true)
                    break
                }
            }
        }
    }
    
    @objc fileprivate func startTimer() {
        self.totalTime = 30
        if countDownTimer == nil {
            self.countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        
        isResendEnabled = false
    }
    
    @objc fileprivate func updateTimer() {
        if totalTime > 1 {
            totalTime.decrement()
            self.timerLabel.text = "\(totalTime) sec"
        } else {
            endTimer()
        }
    }
    
    fileprivate func endTimer() {
        self.countDownTimer?.invalidate()
        self.countDownTimer = nil
        isResendEnabled = true
        
        if presenter?.shouldShowWhatsappLogin() ?? false {
            self.enableWhatsAppLogin()
        }
    }

    fileprivate enum Direction { case left, right }
    
    fileprivate func setNextResponder(_ index:Int?, direction:Direction) {
        guard let index = index else { return }
        
        if direction == .left {
            index == 0 ?
                (_ = otpTextFieldsOutletCollection.first?.resignFirstResponder()) :
                (_ = otpTextFieldsOutletCollection[(index - 1)].becomeFirstResponder())
        } else {
            index == otpTextFieldsOutletCollection.count - 1 ?
                (_ = otpTextFieldsOutletCollection.last?.resignFirstResponder()) :
                (_ = otpTextFieldsOutletCollection[(index + 1)].becomeFirstResponder())
        }
    }

    @IBAction func resendCodeAgain(sender: AnyObject) {
        presenter?.otpResendCount.increment()
        self.startTimer()
        self.presenter?.logGAClickEvent(for: "resend_otp")
        LoginGAPManager.logTappedEvent(with: .resendOTP, forController: self)
        
        if presenter?.isFbSignup == true {
            presenter?.requestFacebookToResendOTP()
        } else{
            presenter?.requestToResendOTP()
        }
    }
    
    @IBAction func whatsAppLogin(sender:AnyObject) {
        presenter?.logGAClickEvent(for: "login_with_whatsapp")
        SignInGAPManager.signinOrSignUpEvent(withEventType: .startedSignIn, withMethod: .whatsApp, withVerifyType: nil, withOtherDetails: ["from_page":"whatsAppBtnClickInOTPScreen"])
        WhatsappHelper.shared.referralCode = presenter?.referralCode ?? ""
        WhatsappHelper.shared.delegate = self
        ActivityIndicator.show(on: self.view, withMessage: "Logging in with Whatsapp..")
        WhatsAppManager.shared.loginWithWhatsapp(referralCode: nil)
    }
}

extension OtpVerificationViewController: WhatsappHelperDelegate {
    
    func loginSuccessful(verifiedData: OtpVerifiedData?, extraKeys:String?) {
        presenter?.isWhatsAppLogin = true
        ActivityIndicator.hide(on: self.view)
        WhatsappHelper.shared.delegate = nil
        if let verifiedData = verifiedData, verifiedData.isExistingUser == false {
            presenter?.userVerificationData = verifiedData
            presenter?.navigateToSignUpScreen(extraKeys: extraKeys)
        }
        else{
            SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .whatsApp, withVerifyType: .whatsapp, withOtherDetails: nil)
            SignInGAPManager.logGenericEventWithoutScreen(for: "loginSuccessNew", otherParams:["medium":"whatsapp","verificationChannel":"whatsapp"])
            userSuccessfullyLoggedIn(verificationData: presenter?.userVerificationData)
        }
    }
    
    func loginFailed(error: Any?) {
        WhatsappHelper.shared.delegate = nil
        ActivityIndicator.hide(on: self.view)
        showError(error)
    }
}

extension OtpVerificationViewController: UITextFieldDelegate {
    //MARK: TextField Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 0 {
            if string.utf16.count == 1 {
                textField.text = string
                 setNextResponder(textFieldsIndexes[textField], direction: .right)
            }
            
            if textField == otpTextFieldsOutletCollection[3] && self.getOtpFromTextFields().count == 4 {
                self.continueTapped(sender: "" as AnyObject)
                isContinueEnabled = true
            } else {
                isContinueEnabled = false
            }
            return false
        } else if range.length == 1 {
            textField.text = ""
            setNextResponder(textFieldsIndexes[textField], direction: .left)
            return false
        }
        
        return false
    }
}

extension OtpVerificationViewController: OTPVerificationPresenterToViewProtocol {
    
    func verifyOTPRequestSuccessResponse(message: String?) {
        ActivityIndicator.hide(on: self.view)
        guard let message = message, !message.isEmpty else { return }
        AuthAlert.showToastMessage(on: self, message: message)
    }
    
    func verifyOTPRequestFailedResponse(error: ErrorData?) {
        ActivityIndicator.hide(on: self.view)
        showError(error)
        otpTextFieldsOutletCollection[3].becomeFirstResponder()
    }
    
    func requestToResendOTPSuccessResponse() {
        ActivityIndicator.hide(on: self.view)
        prepareOtpTextFiled()
    }
    
    func requestToResendOTPFailedResponse(error: ErrorData?) {
        ActivityIndicator.hide(on: self.view)
        showError(error)
    }
}
