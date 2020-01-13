//
//  LoginWelcomeHeaderCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 26/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class LoginWelcomeTableCell: UITableViewCell {
    
    @IBOutlet weak var primaryImageView: UIImageView!
    @IBOutlet weak var loginHeaderLabel: UILabel!
    
    static var height: CGFloat = 220.0
        
    override func awakeFromNib() {
        super.awakeFromNib()
        doInitialConfigurations()
    }
    
    func doInitialConfigurations() {
        loginHeaderLabel
            .setColor(color: .black)
            .setFont(fontType: .title2)
            
        primaryImageView.image = .loginHeader
    }
}
