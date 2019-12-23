//
//  LoginWelcomeCollectionCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 03/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class LoginWelcomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textLabelBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var textLabelTrailingLayout: NSLayoutConstraint!
    @IBOutlet weak var textLabelTopLayout: NSLayoutConstraint!
    @IBOutlet weak var backgroundBlueView: UIView!
    var isSkipEnabled:Bool = false
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var bgLogoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        doInitialConfigurations()
    }
    
    func doInitialConfigurations(){
        userImageView.isHidden = true
        bottomImageView.isHidden = false
        backgroundBlueView.backgroundColor = .customBlue
        bgLogoImageView.image = nil
        bgImageView.image = nil
        textLabel.numberOfLines = 0
        textLabel.setTextColor(.white, fontType: .regular, andFontSize: 15)
        skipButton.setTitle("SKIP", for: .normal)
       // if FireBaseHandler.getBoolFor(keyPath: .hideLoginSkipButton) && FirebaseRemoteHelper.sharedInstance.getRemoteFunctionBoolValue(forkey: "hide_login_skip_button") && self.isSkipEnabled == false {
            skipButton.isHidden = true
        //}
    }
    
    func configureCellDetails(data: LoginWelcomeDataModel) {
        textLabel.attributedText = data.titleSubtitleText
        self.textLabelBottomLayout?.constant = 40
        self.textLabelTrailingLayout?.constant = -80
        
        self.bgImageView.image = nil
        self.bgLogoImageView.image = nil
        self.bottomImageView.image = nil
        
        if let bgimage = data.bgImage {
            if let imageurl = URL(string: bgimage), UIApplication.shared.canOpenURL(imageurl){
                AuthDepedencyInjector.uiDelegate?.setImage(for: bgImageView, url: imageurl, placeholder: nil)
            }
            else{
                self.bgImageView.image = UIImage(named: bgimage)
            }
        }
        if let bgimage = data.logoImage {
            if let imageurl = URL(string: bgimage), UIApplication.shared.canOpenURL(imageurl){
                AuthDepedencyInjector.uiDelegate?.setImage(for: bgLogoImageView, url: imageurl, placeholder: nil)
            }
            else{
                self.bgLogoImageView.image = UIImage(named: bgimage)
            }
            self.textLabelTopLayout.constant = 75
        }
        else{
            self.textLabelTopLayout.constant = 20
        }

        if data.branchData != nil { //Refer earn pages
            self.textLabelBottomLayout?.constant = 10
            self.textLabelTrailingLayout?.constant = 8
            if let urlstr = data.branchData?["userimage"] as? String, let url = URL(string: urlstr) {
                self.layoutIfNeeded()
                userImageView.makeCircleWithBorderColor(UIColor.clear)
                userImageView.image = #imageLiteral(resourceName: "refericon")
                AuthDepedencyInjector.uiDelegate?.setImage(for: userImageView, url: url, placeholder: nil)
            }
            else{
                userImageView.image = #imageLiteral(resourceName: "refericon")
            }
            userImageView.isHidden = false
            bottomImageView.isHidden = true
        }
        else{ //default tutorial pages
            userImageView.isHidden = true
            bottomImageView.isHidden = false
        }
        
        if let imagename = data.bgCornerImage {
            if let imageurl = URL(string: imagename), UIApplication.shared.canOpenURL(imageurl){
                AuthDepedencyInjector.uiDelegate?.setImage(for: bottomImageView, url: imageurl, placeholder: nil)
            }
            else{
                bottomImageView.image = UIImage(named: imagename)
            }
        }
        /*if FireBaseHandler.getBoolFor(keyPath: .hideLoginSkipButton) && FirebaseRemoteHelper.sharedInstance.getRemoteFunctionBoolValue(forkey: "hide_login_skip_button") && self.isSkipEnabled == false {
            skipButton.isHidden = true
        } else {
            skipButton.isHidden = false
        }*/
        self.layoutIfNeeded()
    }
    
    func getAttributedText(text:String, font: UIFont) -> NSMutableAttributedString{
        let paragrapStyle = NSMutableParagraphStyle()
        paragrapStyle.paragraphSpacing = 5.0
        let attributedText : NSMutableAttributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font,NSAttributedString.Key.paragraphStyle:paragrapStyle])
        return attributedText
    }
    
}
