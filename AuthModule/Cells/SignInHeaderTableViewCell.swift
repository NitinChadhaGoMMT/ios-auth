//
//  SignInHeaderTableViewCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class SignInHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var signInTextLabel: UILabel!
    @IBOutlet weak var signInTextLogoLabel: UILabel!
    @IBOutlet weak var signInLogoImageView: UIImageView!
    var cellType: SignInCellType?
    
    static let height:CGFloat = 170
    
    override func awakeFromNib() {
        signInLogoImageView.image = #imageLiteral(resourceName: "passwordImage")
        backbtn.setImage(#imageLiteral(resourceName: "backArrowNew"), for: .normal)
    }
    
}
