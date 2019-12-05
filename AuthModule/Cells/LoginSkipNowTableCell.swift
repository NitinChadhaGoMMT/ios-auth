//
//  LoginSkipNowTableCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 27/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

protocol LoginSkipNowTableCellDelegate: class {
    func didSelectShowTermsAndConditions()
    func didSelectSkipNow()
}

class LoginSkipNowTableCell: UITableViewCell {
    
    @IBOutlet weak var termsAndConditionLabel: UILabel!
    
    weak var delegate: LoginSkipNowTableCellDelegate?
    
    static let height:CGFloat = 50
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doInitialConfigurations()
    }
    
    func doInitialConfigurations() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tncPressed))
        termsAndConditionLabel.addGestureRecognizer(tap)
        
        termsAndConditionLabel
            .setColor(color: .customGray)
            .setFont(fontType: .regular, size: 10.0)

        let simpleText: NSString = Constants.kTnCText as NSString
        termsAndConditionLabel.text = simpleText as String
        let mutableString = NSMutableAttributedString(attributedString: termsAndConditionLabel.attributedText!)
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.customBlue, range: simpleText.range(of: Constants.kTnC))
        termsAndConditionLabel.attributedText = mutableString
    }
    
    @IBAction func actionSkipNowPressed(_ sender: UIButton) {
        delegate?.didSelectSkipNow()
    }
    
    @objc func tncPressed() {
        delegate?.didSelectShowTermsAndConditions()
    }
}
