//
//  LoginFBSingupTableCell.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 27/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit


protocol LoginFBSingupTableCellDelegate: NSObjectProtocol {
    func connectWithFB()
}


class LoginFBSingupTableCell: UITableViewCell {
    
    @IBOutlet weak var buttonTitleLabel: UILabel!
    @IBOutlet weak var fbIconImageView: UIImageView!
    @IBOutlet weak var fbButtonView: UIView!
    
    weak var delegate: LoginFBSingupTableCellDelegate?
    
    static let height:CGFloat = 50
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doInitialConfigurations()
    }
    
    func doInitialConfigurations() {
       let tap = UITapGestureRecognizer(target: self, action: #selector(fbSignInClicked))
       fbButtonView.addGestureRecognizer(tap)
       fbButtonView.backgroundColor = .customBlue
       fbButtonView.layer.cornerRadius = 8.0
       fbButtonView.layer.masksToBounds = true
       buttonTitleLabel.text = "Continue with Facebook"
       fbIconImageView.image = #imageLiteral(resourceName: "fBFLogoWhite")
    }
    
    func configureCellWith(fbButtonTitle text: String){
        buttonTitleLabel.text = text
    }
    
    @objc func fbSignInClicked(){
        self.delegate?.connectWithFB()
    }
    
}
