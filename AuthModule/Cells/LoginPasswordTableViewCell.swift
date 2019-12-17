//
//  LoginPasswordTableViewCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

protocol LoginPasswordCellProtocol: class {
    func didUpdatedPassword(newPassword: String?)
    func didSelectForgotPassword()
}

class LoginPasswordTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var textFieldBottomLineView: UIView!
    
    weak var delegate: LoginPasswordCellProtocol?
    var cellType: SignInWithPasswordPresenter.SignInCellType?
    
    static let height: CGFloat = 90.0
    
    var eyeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doInitialConfigurations()
    }
    
    func doInitialConfigurations() {
        self.setAccessbilityForComponents()
        configurePasswordTextfield()
        addRightViewInTextField()
    }
    
    func setAccessbilityForComponents() {
        self.passwordTextField.isAccessibilityElement = true
        self.passwordTextField.accessibilityLabel = "LoginPassword_TextField"
    }
    
    func configurePasswordTextfield() {
        passwordTextField.delegate = self
        passwordTextField.showAccessoryViewWithButtonTitle("Dismiss")
        passwordTextField.returnKeyType = .default
        passwordTextField.layer.cornerRadius = 25.0
        passwordTextField.layer.masksToBounds = true
    }
    
    func addRightViewInTextField(){
        eyeImageView = UIImageView(image: #imageLiteral(resourceName: "eyeSlashed"))
        if let size = eyeImageView.image?.size {
            eyeImageView.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 20.0, height: size.height)
        }
        eyeImageView.contentMode = UIView.ContentMode.center
        eyeImageView.addTapGestureWithAction(#selector(showHidePassword), target: self)
        passwordTextField.rightView = eyeImageView
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightViewMode = .always
        
        let paddingView: UIView = UIView(frame: CGRect(x: 10.0, y: 0, width: 20, height: 20))
        passwordTextField.leftView = paddingView
        passwordTextField.leftViewMode = .always
    }
    
    @objc func showHidePassword(){
        passwordTextField.isSecureTextEntry.toggle()
        eyeImageView.image = passwordTextField.isSecureTextEntry ? #imageLiteral(resourceName: "eyeSlashed") : #imageLiteral(resourceName: "view1")
    }
    
    //MARK: Public Methods
    func configureCellWithText(text: String?, placeHolderText: String?, andCellType cellType: SignInWithPasswordPresenter.SignInCellType) {
        self.cellType = cellType
        passwordTextField.text = text
        passwordTextField.placeholder = placeHolderText
    }
    
    @IBAction func actionForgotPassword(_ sender: AnyObject) {
        delegate?.didSelectForgotPassword()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        delegate?.didUpdatedPassword(newPassword: "")
    }
    
    //MARK: TextField Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textEntered = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        delegate?.didUpdatedPassword(newPassword: textEntered)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textEntered = textField.text! as NSString
        textField.resignFirstResponder()
        delegate?.didUpdatedPassword(newPassword: textEntered as String)
        return true
    }
}

