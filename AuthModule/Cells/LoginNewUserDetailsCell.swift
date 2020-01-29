//
//  LoginNewUserDetailsCell.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 26/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

protocol LoginNewUserDetailsCellDelegate : class {
    func continueButtonAction(with mobileNumber: String)
}

class LoginNewUserDetailsCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var continueButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var referralView: UIView!
    @IBOutlet weak var refreeStatusLabel: UILabel!
    @IBOutlet weak var refreeStatusLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginReferralImageView: UIImageView!
    weak var delegate: LoginNewUserDetailsCellDelegate?
    @IBOutlet weak var countryFlagImageView: UIImageView!
    
    static var height: CGFloat {
        return AuthUtils.isBranchDictionaryPresent || !AuthUtils.isUserLoggedInBefore ? 220.0 : 180.0
    }
     
    var isContinueButtonEnabled: Bool = false {
        didSet {
            continueButton.isUserInteractionEnabled = isContinueButtonEnabled
            continueButton.backgroundColor = isContinueButtonEnabled ? .goOrange : .goLightGrey
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doInitialConfigurations()
    }

    @IBAction func actionContinuePressed(_ sender: AnyObject) {
        delegate?.continueButtonAction(with: mobileNumberTextField.text!)
    }
    
    override func prepareForReuse() {
        AuthAnimation.flipView(view: self.loginReferralImageView)
    }
    
    func doInitialConfigurations() {
        self.setAccessbilityForComponents()
        continueButton.setTextColor(.white, fontType: .medium, andFontSize: 16.0)
        continueButton.setFont(font: UIFont.fontsWith(fontType: .sfProRegular, size: 15.0))
        continueButton.setTitle(.kContinue, for: .normal)
        continueButton.titleLabel?.textColor = .white
        continueButton.makeCornerRadiusWithValue(5.0, borderColor: nil)
        mobileNumberTextField.placeholder = "Enter Mobile Number"
        mobileNumberTextField.delegate = self
        mobileNumberTextField.font = .title2
        mobileNumberTextField.showAccessoryViewWithButtonTitle(.kDismiss)
        mobileNumberTextField.layer.cornerRadius = 25.0
        mobileNumberTextField.layer.masksToBounds = true
        mobileNumberTextField.leftViewMode = .always
        mobileNumberTextField.leftView = UIView(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: 84, height: 15))
        self.referralView.isHidden = true
        self.continueButtonTopConstraint.constant = 15
        
        if FireBaseHandler.getRemoteFunctionBoolValue(forKey: "autoFocusMobileInput") {
            self.mobileNumberTextField.becomeFirstResponder()
        }
        
        countryFlagImageView.image = .indianFlag
        loginReferralImageView.image = .giftIcon
             
        isContinueButtonEnabled = false
        AuthAnimation.flipView(view: self.loginReferralImageView)
    }
    
    func configureReferralView(with name:String) {
        self.referralView.isHidden = false
        self.continueButtonTopConstraint.constant = 65
        
        refreeStatusLabel
            .setFont(fontType: .caption2)
            .setColor(color: .iconGrey)
        
        var status = FireBaseHandler.getStringFor(keyPath: .loginReferralStatus, dbPath: .goAuthDatabase) ?? "Wow! Looks like {{name}} has referred you.\n You earned <b>Rs.150 goCash+.<b>"
        status = status.replacingOccurrences(of: "{{name}}", with: name)
        self.refreeStatusLabel.attributedText = status.convertHTMLTagsIntoString()
    }
    
    func configureGenericReferralView() {
        
        guard AuthUtils.isUserLoggedInBefore == false else { return }
        
        self.referralView.isHidden = false
        self.refreeStatusLabelTopConstraint.constant = 10
        
        refreeStatusLabel
            .setColor(color: .iconGrey)
            .setFont(fontType: .tiny)
        
        self.refreeStatusLabel.numberOfLines = 1
        self.continueButtonTopConstraint.constant = 65
        let status = FireBaseHandler.getStringFor(keyPath: .loginGenericReferralStatus, dbPath: .goAuthDatabase) ?? "Sign-up and earn <b>Rs.100 goCash+<b> instantly."
        self.refreeStatusLabel.attributedText = status.convertHTMLTagsIntoString()
    }
    
    func setAccessbilityForComponents() {
        self.continueButton.isAccessibilityElement = true
        self.continueButton.accessibilityLabel = "LoginWelcome_continueButton"
        self.mobileNumberTextField.isAccessibilityElement = true
        self.mobileNumberTextField.accessibilityLabel = "LoginWelcome_mobileNumberTextField"
    }
    
    //MARK: TextField Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textEntered = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if AuthUtils.isValidTextForMobileField(textField, shouldChangeCharactersIn: range, replacementString: string) {
            isContinueButtonEnabled = (textEntered.count == 10)
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.continueButtonAction(with: textField.text!)
        return true
    }
}

