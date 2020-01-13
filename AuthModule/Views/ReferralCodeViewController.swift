//
//  ReferralCodeViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 10/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol applyReferralProtocol: NSObject {
    func applyCode(with code:String)
}

class ReferralCodeViewController: LoginBaseViewController, ReferralCodePresenterToViewProtocol {
    
    @IBOutlet weak var referralTextFiled: UITextField!
    @IBOutlet weak var invalidMsgLabel: UILabel!
    @IBOutlet weak var referralCodeWarningImg: UIImageView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var applyCodeButton: UIButton!

    weak var delegate:applyReferralProtocol?
    
    var presenter: ReferralCodeViewToPresenterProtocol?
    
    private var isAppyCodeButtonEnabled: Bool = false {
        didSet {
            applyCodeButton.isUserInteractionEnabled = isAppyCodeButtonEnabled
            applyCodeButton.backgroundColor = isAppyCodeButtonEnabled ? .goBlue : .goLightGrey
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialConfiguration()
    }
    
    fileprivate func doInitialConfiguration() {
        self.referralTextFiled.becomeFirstResponder()
        self.referralTextFiled.layer.borderWidth = 0.0
        self.referralTextFiled.layer.borderColor = UIColor.clear.cgColor
        self.invalidMsgLabel.isHidden = true
        self.referralCodeWarningImg.isHidden = true
        applyCodeButton.titleLabel?.textColor = .white
        self.view.addTapGestureWithAction(#selector(dismissReferralCode), target: self)
        isAppyCodeButtonEnabled = false
        
        topImageView
            .setImage(_image: .giftIcon)
            .setCornerRadius(radius: 20.0)
        
        referralCodeWarningImg.image = .errorIcon
    }
    
    @objc fileprivate func dismissReferralCode() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showReferralError() {
        self.referralTextFiled.layer.borderWidth = 1.0
        self.referralTextFiled.layer.borderColor = UIColor.red.cgColor
        self.referralCodeWarningImg.isHidden = false
        self.invalidMsgLabel.isHidden = false
        
    }
    
    @IBAction func applyCodeTapped(_ sender: Any) {
        if presenter?.isValid() ?? false {
            self.validateReferralCode(presenter?.referralCodeEntered ?? "")
        }
    }
    
    func validateReferralCode(_ code: String) {
        presenter?.validateReferralCode()
    }
}


extension ReferralCodeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter?.referralCodeEntered = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        isAppyCodeButtonEnabled = presenter?.isValid() ?? false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isAppyCodeButtonEnabled = true
        return true
    }
}
