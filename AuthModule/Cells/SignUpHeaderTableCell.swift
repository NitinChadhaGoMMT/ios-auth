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
        primaryImageView.image = .onlineOrder
        
        self.headerLabel
            .setColor(color: .goBlack)
            .setFont(fontType: .title1)
            
        let header = FireBaseHandler.getStringFor(keyPath: .signUpHeaderNewUI, dbPath: .goAuthDatabase) ?? "Almost Done!"
        headerLabel.attributedText = NSAttributedString(string:header)
    }
}

protocol SignUpTextInputViewCellDelegate: class {
    func didChangeText(text: String)
    func didDismissKeyBoard()
    func didContinueTapped()
}

class SignUpTextInputViewCell: UITableViewCell {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputTextFiled: UITextField!
    
    weak var delegate: SignUpTextInputViewCellDelegate?
    static let height:CGFloat = 200.0
    
    var isContinueButtonEnable: Bool = false {
        didSet {
            continueButton.isUserInteractionEnabled = isContinueButtonEnable
            continueButton.backgroundColor = isContinueButtonEnable ? .goOrange : .lightGray
            continueButton.titleLabel?.textColor = isContinueButtonEnable ? UIColor.white : UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        inputTextFiled.showAccessoryViewWithButtonTitle("Dismiss")
        inputTextFiled.delegate = self
        inputTextFiled.returnKeyType = .default
        inputTextFiled.setCornerRadius(radius: 25.0)
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
        continueButton.setCornerRadius(radius: 8.0)
        continueButton.setTitle("DONE", for: .normal)
        isContinueButtonEnable = false
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        delegate?.didContinueTapped()
    }
}

extension SignUpTextInputViewCell: UITextFieldDelegate {
    //MARK: Textfield delegate methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if AuthUtils.isValidName(newText) || newText.isEmpty {
            isContinueButtonEnable = !newText.isEmpty
            delegate?.didChangeText(text: newText)
            return true
        }
        return false
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

