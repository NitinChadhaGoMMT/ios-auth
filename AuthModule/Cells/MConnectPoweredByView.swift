//
//  MConnectPoweredByView.swift
//  Goibibo
//
//  Created by AshokKumar on 22/02/17.
//  Copyright © 2017 ibibo Web Pvt Ltd. All rights reserved.
//

import UIKit

class MConnectPoweredByView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.setTextColor(.darkGray, fontType: .medium, andFontSize: 15)
        titleLabel.text = "Powered by Mobile Connect"
        iconImage.image = .mConnectIcon
    }
    
}
