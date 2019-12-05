//
//  LoginNewUserDetailsCell.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 26/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

protocol LoginNewUserDetailsCellDelegate : class {
    func didSelectedNewUserLogin(with mobileNumber: String)
}

class LoginNewUserDetailsCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var textFieldBottomView: UIView!
    
    weak var delegate: LoginNewUserDetailsCellDelegate?
    
    static let height:CGFloat = 125
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doInitialConfigurations()
    }
    
    
    @IBAction func actionWhatsappPressed(_ sender: Any) {
      //<NITIN>  UserDataManager.sharedInstance().isWAChecked = !UserDataManager.sharedInstance().isWAChecked
    }
    
    @IBAction func actionContinuePressed(_ sender: AnyObject) {
        delegate?.didSelectedNewUserLogin(with: mobileNumberTextField.text!)
    }
    
    func doInitialConfigurations() {
        self.setAccessbilityForComponents()
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = .customOrangeColor
        continueButton.layer.cornerRadius = 5.0
        continueButton.layer.masksToBounds = true
        textFieldBottomView.backgroundColor = .customBackgroundColor
        mobileNumberTextField.placeholder = Constants.kMobileNumberPlaceholder
        mobileNumberTextField.delegate = self
        mobileNumberTextField.showAccessoryViewWithButtonTitle(Constants.kDismiss)
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
        
        if textEntered.count > 10 {
            return false
        }
        
        let blockedCharSet = NSMutableCharacterSet.decimalDigit().inverted
        let invalidRange = textEntered.rangeOfCharacter(from: blockedCharSet)
        
        if invalidRange != nil {
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didSelectedNewUserLogin(with: textField.text!)
        return true
    }
}
