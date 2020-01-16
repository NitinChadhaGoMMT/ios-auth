//
//  MobileVerificationViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 24/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class MobileVerificationViewController: LoginBaseViewController, MobileVerificationPresenterToViewProtocol, UITextFieldDelegate {
    
    let circleText = "ⓘ"
    
    @IBOutlet weak var scrollViewBottomConstraint : NSLayoutConstraint!
    @IBOutlet weak var mconnectContainerViewHeight : NSLayoutConstraint!
    @IBOutlet weak var verificationScrollView: UIScrollView!
    @IBOutlet weak var mconnectContainerView : UIView!
    
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var goCashLabel: UILabel!
    
    @IBOutlet weak var mobileNumField: UITextField!
    @IBOutlet weak var continueLabel: UILabel!
    
    @IBOutlet weak var tncFirstLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    var socialGraphtermsAndConditionLink: String?
    var mobileNo: String?
    var presenter: MobileVerificationViewToPresenterProtocol?
    
    override func viewDidLoad() {
        self.title = "Verify Your Mobile Number"
        super.viewDidLoad()
        self.configureUserInterface()
        presenter?.checkForMobileConnect()
        SignInGAPManager.logOpenScreenEvent(for: .verifyPhone, otherParams: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func configureUserInterface() {
        
        self.mobileNumField.delegate = self
        self.mobileNumField.text = self.mobileNo
        //self.navigationController?.isNavigationBarHidden = true
        self.mconnectContainerViewHeight.constant = 0
        self.continueLabel.makeCornerRadiusWithValue(10.0, borderColor: UIColor.clear)
        self.titleLabel.setTextColor(.black, fontType: .medium, andFontSize: 18)
        self.textLabel1.setTextColor(.blue, fontType: .medium, andFontSize: 12)
        self.textLabel2.setTextColor(.blue, fontType: .medium, andFontSize: 12)
        self.textLabel3.setTextColor(.blue, fontType: .medium, andFontSize: 12)
        
        self.titleLabel.text = "Verify Your Phone"
        self.textLabel1.text = "Save Big with goCash"
        self.textLabel2.text = "Sync Bookings on your phone"
        self.textLabel3.text = "Easy One-Touch Login"
        self.image1.image = .goCash
        self.image2.image = .questions
        self.image3.image = .clickIcon
        
        var infoText = "Earn goCash+ and use for bookings. \nNo usage limits"
        
        if !AuthUtils.isEmptyString(presenter?.referralCode) {
            infoText = "Claim your reward of Rs 2000 goCash and use for bookings."
        }
        
        let gocashText : NSMutableAttributedString = NSMutableAttributedString(string: infoText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 12)!])
        
        let gocashIcon = NSMutableAttributedString(string:"\(circleText)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customBlue, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 12)!])
        
        gocashText.append(gocashIcon)
        
        continueLabel.backgroundColor = UIColor.customBlue
        continueLabel.addTapGestureWithAction(#selector(continueTapped), target: self)
        
        let attributedText : NSMutableAttributedString = NSMutableAttributedString(string:"We will send you a verification code on this number. By proceeding, you agree to ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 12)!])
        
        let tncStr = NSMutableAttributedString(string:"Terms & Conditions", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customBlue, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 12)!])
        attributedText.append(tncStr)
        
        self.tncFirstLabel.attributedText = attributedText
        
        self.tncFirstLabel.addTapGestureWithAction(#selector(termsAndConditionAction), target: self)
        
    }
    
    func switchToExpandedHeader(navigationBar: UINavigationBar?) {
        navigationBar?.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
        navigationBar?.shadowImage = UIImage()
    }
    
    
    //MARK:- Mconnect Handling
    
    override func addMconnectView() {
        self.mconnectContainerViewHeight.constant = 60
        self.view.layoutIfNeeded()
        if let view = AuthUtils.bundle.loadNibNamed("MConnectPoweredByView", owner: self, options: nil)?.first as? MConnectPoweredByView {
            self.mconnectContainerView.addSubview(view)
        }
    }
    
    override func handleMConnectFailure(mobileNo: String) {
        self.verifyMobileWithNumber(mobileNo)
    }
    
    override func handleMConnectSuccessData(_ responseData: Any?, mobileNo: String){
        if let data = responseData as? MconnectVerifiedData {
            if let verificationData = data.mobileVerifiedData, verificationData.isSuccess == true {
                if verificationData.isSendOtp {
                    self.performSegue(withIdentifier: "numberToOtpSegue", sender: verificationData)
                }
                else {
                    presenter?.navigateToPasswordScreen(verifiedData: verificationData)
                }
            }
            else if let otpVerifiedData = data.otpVerifiedData, otpVerifiedData.isSuccess == true {
                self.presenter?.userVerificationData = otpVerifiedData
                self.presenter?.isverifyMethodOtp = true
                if  otpVerifiedData.userStatusType == .loggedIn || otpVerifiedData.userStatusType == .verified{
                    SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .phone, withVerifyType: .mconnect, withOtherDetails: nil)
                    self.userSuccessfullyLoggedIn()
                }
                else{
                    self.performSegue(withIdentifier: "mobileToUserSignup", sender:nil)
                }
            }
            else{
                self.verifyMobileWithNumber(mobileNo)
            }
        }
        else{
            self.verifyMobileWithNumber(mobileNo)
        }
    }
    
    //MARK:- Verify Mobile No
    
    func verifyMobileWithNumber(_ mobileNo:String) {
        
        self.mobileNo = mobileNo
        
        if presenter?.isFbSignup == true {
            presenter?.requestFBOTPWithMobileNo(mobileNo)
            return
        }
        
        presenter?.verifyMobileNumber(number: mobileNo)
    }
    
    //MARK: Button actions
    
    @objc func termsAndConditionAction(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        if self.scrollViewBottomConstraint.constant != 0 {
            self.scrollViewBottomConstraint.constant = 0
            self.verificationScrollView.contentOffset = CGPoint(x: 0.0, y: -20.0)
        }
        
        self.navigationController?.isNavigationBarHidden = false
        //<NITIN>
        /*let webViewController  = RandomWebPush.getInstance()
        webViewController.customTitle = "Terms and Conditions"
        webViewController.customUrl = socialGraphtermsAndConditionLink ?? ""
        self.navigationController?.pushViewController(webViewController, animated: true)*/
    }
    
    func goCashInfoAction(sender: AnyObject) {
        
        if self.scrollViewBottomConstraint.constant != 0 {
            self.scrollViewBottomConstraint.constant = 0
            self.verificationScrollView.contentOffset = CGPoint(x: 0.0, y: -20.0)
        }
        
        self.view.endEditing(true)
        
        AuthDepedencyInjector.AnalyticsDelegate?.logCategory(event: "OTP_INFO_BUTTON_CLICK", dictionary: nil)
        //<NITIN>
        /*let dashBoard  = UserGoCashDashboard(nibName: "UserGoCashDashboard", bundle: nil)
        dashBoard.isSocialFlow = true
        self.navigationController?.pushViewController(dashBoard , animated:UserGoCashDashboard.shouldShowGoCashHelper())*/
    }
    
    
    
    @objc func continueTapped() {
        
        if self.scrollViewBottomConstraint.constant != 0 {
            
            self.scrollViewBottomConstraint.constant = 0
            self.verificationScrollView.contentOffset = CGPoint(x: 0.0, y: -20.0)
        }
        
        self.view.endEditing(true)
        
        if !AuthUtils.isValidPhoneNumber(mobileNumField.text) {
            AuthAlert.showInvalidMobileAlert(view: self)
            return
        }
        
        self.mconnectData == nil ? self.verifyMobileWithNumber(self.mobileNumField.text!) : self.verifymConnectDataWithMobileNo(self.mobileNumField.text!, isFbSignup: presenter?.isFbSignup ?? false, referralCode: presenter?.referralCode ?? "")
    }
    
    @IBAction func skipNowTapped(sender: AnyObject) {
        let dict = FireBaseHandler.getDictionaryFor(keyPath: .onboarding)
        
        var skipDiscMessage = "Save more on bookings with goCash+ and goCash. Get all your questions answered by the goibibo community. Access your bookings across all devices."
        
        if let str = dict["d_s_d_ds"] as? String {
            skipDiscMessage = str
        }
        
        AuthAlert.showSkipLoginAlert(withMessage: skipDiscMessage, onView: self, continueAction: { (continueAction) in
            SignInGAPManager.skipButtonTapped(with: .skipDialog , withOtherDetails: ["tap":"dont_skip"])
        }) { (skipAction) in
            SignInGAPManager.skipButtonTapped(with: .skipDialog , withOtherDetails: ["tap":"skip"])
            self.removeBranchReferralData()
            //<NITIN>Utils.resetSecureAccountCount()
            AuthRouter.shared.finishLoginFlow(error: nil)
        }
        
    }
    
    // MARK: UITextFieldDelegate methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if self.scrollViewBottomConstraint.constant != 200 {
            self.scrollViewBottomConstraint.constant = 200
            self.verificationScrollView.contentOffset = CGPoint(x: 0.0, y: -350.0)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return AuthUtils.isValidTextForMobileField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        continueTapped()
        return true
    }
}
