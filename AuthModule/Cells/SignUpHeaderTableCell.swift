//
//  SignupAlmostThereCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class SignUpHeaderTableCell: UITableViewCell {
    
    static let height: CGFloat = 200.0
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var primaryImageView: UIImageView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        primaryImageView.image = #imageLiteral(resourceName: "signUpHeader")
        //self.headerLabel.setTextStyle(.black, font: .title1)
        self.headerLabel.setColor(color: .customBlack).setFont(fontType: .medium, size: 24.0)
        let header = FireBaseHandler.getStringFor(keyPath: .signUpHeaderNewUI, dbPath: .goAuthDatabase) ?? "Almost Done!"
        headerLabel.attributedText = NSAttributedString(string:header)
    }
}

protocol SignUpTextInputViewCellDelegate: class {
    func didChangeText(text: String)
    func didDismissKeyBoard()
}

class SignUpTextInputViewCell: UITableViewCell {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputTextFiled: UITextField!
    
    weak var delegate: SignUpTextInputViewCellDelegate?
    static let height:CGFloat = 120.0
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        inputTextFiled.showAccessoryViewWithButtonTitle("Dismiss")
        inputTextFiled.delegate = self
        inputTextFiled.returnKeyType = .default
        inputTextFiled.autocapitalizationType = .none
        inputTextFiled.autocorrectionType = .no
        inputTextFiled.isAccessibilityElement = true
        inputTextFiled.accessibilityLabel = "Signin_EmailInput"
        inputTextFiled.accessibilityTraits = UIAccessibilityTraits.button
        inputLabel.text = "What do we call you?"
        inputTextFiled.placeholder = "Rahul"
        //Left Padding
        let paddingView: UIView = UIView(frame: CGRect(x: 10.0, y: 0, width: 20, height: 20))
        inputTextFiled.leftView = paddingView
        inputTextFiled.leftViewMode = .always
    }
}

extension SignUpTextInputViewCell: UITextFieldDelegate {
    //MARK: Textfield delegate methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let set = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ").inverted
        if newText.rangeOfCharacter(from: set) != nil {
            return false
        }
        delegate?.didChangeText(text: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didChangeText(text: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didDismissKeyBoard()
    }
}

