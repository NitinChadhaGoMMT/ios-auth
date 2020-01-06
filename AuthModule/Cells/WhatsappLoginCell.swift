//
//  WhatsappLoginCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol WhatsappLoginCellDelegate: class {
    func connectWithWhatsapp()
    func connectWithFB()
}

class WhatsappLoginCell: UITableViewCell {

    @IBOutlet weak var buttonTitleLabel: UILabel!
    @IBOutlet weak var wpIconImageView: UIImageView!
    @IBOutlet weak var wpButtonView: UIView!
    @IBOutlet weak var fbButtonView: UIView!
    @IBOutlet weak var fbIconImageView: UIImageView!
    @IBOutlet weak var fbBtnTitleLabel: UILabel!
    
    static var height: CGFloat {
        return 50
    }
    
    weak var delegate: WhatsappLoginCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        doInitialConfigurations()
    }
    
    func doInitialConfigurations() {
        wpButtonView.addTapGestureWithAction(#selector(wpSignInClicked), target: self)
        wpButtonView.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.7333333333, blue: 0.3490196078, alpha: 1)
        wpButtonView.makeCornerRadiusWithValue(5.0, borderColor: nil)
        buttonTitleLabel.text = "WhatsApp"
        wpIconImageView.image = #imageLiteral(resourceName: "whatsapp_activity")
        buttonTitleLabel.setTextColor(.white, fontType: .medium, andFontSize: 16.0)
        
        fbButtonView.addTapGestureWithAction(#selector(fbSignInClicked), target: self)
        fbButtonView.backgroundColor = .customBlue
        fbButtonView.makeCornerRadiusWithValue(5.0, borderColor: nil)
        fbBtnTitleLabel.text = "Facebook"
        fbIconImageView.image = #imageLiteral(resourceName: "fBFLogoWhite")
        fbBtnTitleLabel.setTextColor(.white, fontType: .medium, andFontSize: 16.0)
    }
    
    func configureCellWith(wpButtonTitle text: String){
        buttonTitleLabel.text = text
    }
    
    @objc func wpSignInClicked(){
        self.delegate?.connectWithWhatsapp()
    }
    
    @objc func fbSignInClicked(){
        self.delegate?.connectWithFB()
    }
}

