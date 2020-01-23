//
//  UIButton_Extensions.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

extension UIButton {
    
    @discardableResult func setImage(image: UIImage?, state: UIControl.State = .normal) -> UIButton {
        self.setImage(image, for: state)
        return self
    }
    
    func setTextColor(_ colorType: UIColor, fontType: FontType, andFontSize size:CGFloat) {
        self.setTitleColor(colorType, for: .normal)
        self.titleLabel?.font = UIFont.fontWithType(fontType, andSize: size)
    }
    
    @discardableResult func setFont(font: UIFont) -> UIButton {
        self.titleLabel?.setFont(fontType: font)
        return self
    }
    
}
