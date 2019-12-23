//
//  LoginContinueTableViewCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class LoginContinueTableViewCell: UITableViewCell {

    static let height: CGFloat = 60.0
    
    @IBOutlet weak var continueButton: UIButton!
    
    var cellType: SignInCellType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doInitialConfigurations()
    }

    func doInitialConfigurations() {
        self.setAccessbilityForComponents()
        continueButton.layer.cornerRadius = 8
        continueButton.layer.masksToBounds = true
    }
    
    func setAccessbilityForComponents() {
        self.continueButton.isAccessibilityElement = true
        self.continueButton.accessibilityLabel = "LoginPassword_SigninButton"
    }
    
    func configureCell(details: SignInCellType?) {
        cellType = details
        if cellType == .signInButton || cellType ==  .signInButtonContinue {
            continueButton.backgroundColor = .customOrangeColor
            continueButton.setTitle("CONTINUE", for: .normal)
        }
        else if cellType == .signInButtonBlue{
            continueButton.backgroundColor = .customBlue
            continueButton.setTitle("CONTINUE", for: .normal)
        }
        else if cellType == .requestOTP{
            continueButton.backgroundColor = .customBlue
            continueButton.setTitle("REQUEST OTP", for: .normal)
        }
    }
}
