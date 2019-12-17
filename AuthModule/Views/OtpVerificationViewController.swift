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
    
    var presenter: OTPVerificationPresenter?
    
    var isContinueEnabled: Bool = false {
        didSet {
            continueLabel.isUserInteractionEnabled = self.isContinueEnabled
            continueLabel.backgroundColor = self.isContinueEnabled ? .orange : .lightGray
            continueLabel.textColor = self.isContinueEnabled ? UIColor.white : UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserInterface()
        startTimer()
    }
    
    func configureUserInterface() {
        
        editIconButton.setBackgroundImage(#imageLiteral(resourceName: "otp_edit"), for: .normal)
        whatsAppIconButton.setImage(#imageLiteral(resourceName: "otp_wts_app"), for: .normal)
        mobileLogoImageView.image = #imageLiteral(resourceName: "otp_image")
        
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
        
        //<NITIN>
        //if wtsAppShowCount == totalResentCount && (FirebaseRemoteHelper.sharedInstance.getRemoteFunctionBoolValue(forkey: "wtsApp_Otp_Enable")) {
        //            self.enableWhatsAppLogin()
        //}
        
        if let customFont = UIFont(name: "Quicksand-Bold", size: 18){
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : customFont]
        }
        
        if var header = FireBaseHandler.getStringFor(keyPath: .otpHeader, dbPath: .goAuthDatabase) {
            header = header.replacingOccurrences(of: "\\n", with: "\n")
            otpMsgLabel2.attributedText = NSAttributedString(string:header)
        }
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func startTimer() {
        self.totalTime = 30
        if countDownTimer == nil {
            self.countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        
        //UI Updation
        self.resendButton.isEnabled = false
        self.resendButton.isUserInteractionEnabled = false
        self.resendButton.setTitle("Resend OTP in", for: .normal)
        self.resendButton.setTitleColor(UIColor.gray, for: .normal)
        self.timerLabel.isHidden = false
        self.resendButtonConstraint.constant = -20
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc fileprivate func updateTimer() {
        if totalTime > 1 {
            totalTime -= 1
            self.timerLabel.text = "\(totalTime) sec"
        } else {
            endTimer()
        }
    }
    
    fileprivate func endTimer() {
        self.countDownTimer?.invalidate()
        self.countDownTimer = nil
        self.resendButton.setTitle("Resend OTP", for: .normal)
        if #available(iOS 11.0, *) {
            self.resendButton.setTitleColor(UIColor(named:"##2276e3"), for: .normal)
        } else {
            self.resendButton.setTitleColor(UIColor.blue, for: .normal)
        }
        self.timerLabel.isHidden = true
        self.resendButton.isEnabled = true
        self.resendButton.isUserInteractionEnabled = true
        self.resendButtonConstraint.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
        //<NITIN>if wtsAppShowCount == totalResentCount && (FirebaseRemoteHelper.sharedInstance.getRemoteFunctionBoolValue(forkey: "wtsApp_Otp_Enable")) {
                //self.enableWhatsAppLogin()
//        }
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
    
    func verifyOTPRequestSuccessResponse(message: String?) {
        ActivityIndicator.hide(on: self.view)
        guard let message = message, !message.isEmpty else { return }
        AuthAlert.showToastMessage(on: self, message: message)
    }
    
    func verifyOTPRequestFailedResponse(error: ErrorData?) {
        ActivityIndicator.hide(on: self.view)
        handleError(error)
        otpTextFieldsOutletCollection[3].becomeFirstResponder()
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
