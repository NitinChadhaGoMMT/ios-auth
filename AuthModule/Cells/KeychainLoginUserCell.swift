//
//  KeychainLoginUserCellCollectionViewCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 19/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class KeychainLoginUserCell: UICollectionViewCell {
    
    @IBOutlet weak var backShadowVieew: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var phoneNumberAndNameLabel: UILabel!
    
    func setData(data:[String:Any]?){
        if let dataValue = data{
            var name  = ""
            var secondValue = ""
            if let nameValue = dataValue["name"] as? String{
                name = nameValue
            }
            if let value = dataValue["email"] as? String{
                secondValue = value
            }
            if let numberValue = dataValue["phone"] as? String{
                secondValue = numberValue
            }
            let userInfoAttributedString = NSMutableAttributedString()
            userInfoAttributedString.append(NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                                          NSAttributedString.Key.font: UIFont.fontWithType(FontType.regular, andSize: 16)]))
            userInfoAttributedString.append(NSAttributedString(string: "\n" + secondValue, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray,
                                                                                                        NSAttributedString.Key.font: UIFont.fontWithType(FontType.regular, andSize: 13)]))
            
            phoneNumberAndNameLabel.attributedText = userInfoAttributedString
            
            profileImage.image = #imageLiteral(resourceName: "icon_personalProfile")
            
            if let value = dataValue["profilePic"] as? String,value != ""{
                AuthDepedencyInjector.uiDelegate?.setImage(for: profileImage, url: URL(string:value)!, placeholder: #imageLiteral(resourceName: "icon_personalProfile"))
            }
            
        }
        profileImage.makeCircleWithBorderColor(UIColor.black)
        
        profileImage.makeCornerRadiusWithValue(20)
        backShadowVieew.layer.cornerRadius = 7.0
        backShadowVieew.layer.masksToBounds = true
        backShadowVieew.clipsToBounds = false
        backShadowVieew.addShadowWithColor(UIColor.lightGray, offset: CGSize(width: 0, height: 1))
    }
}

