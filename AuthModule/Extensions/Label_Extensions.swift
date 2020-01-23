//
//  UILabel_Extensions.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setTextColor(_ colorType: UIColor, fontType: FontType, andFontSize size:CGFloat) {
        self.textColor = colorType
        self.font = UIFont.fontWithType(fontType, andSize: size)
    }
    
    @discardableResult func setColor(color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }
    
    @discardableResult func setFont(fontType: UIFont) -> UILabel {
        self.font = fontType
        return self
    }
    
    @discardableResult func addTapGesture(_ action: Selector, target: AnyObject?) -> UILabel {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
        return self
    }
}
