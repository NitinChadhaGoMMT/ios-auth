//
//  UITextfield_Extensions.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

extension UITextField {
    
    func showAccessoryViewWithButtonTitle(_ title: String) {
        
        let width = UIApplication.shared.keyWindow!.bounds.size.width
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        view.backgroundColor = .goBlue
        view.layer.borderColor = UIColor.goLightGrey.cgColor
        
        view.layer.borderWidth = 0.5
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: width - 80, y: 10, width: 70, height: 30)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .goBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.setFont(fontType: UIFont.fontsWith(fontType: .sfProRegular, size: 14.0))
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(UITextField.hideKeyboard), for: .touchUpInside)
        
        view.addSubview(button)
        
        self.inputAccessoryView = view;
        self.reloadInputViews()
    }
    
    @objc func hideKeyboard() {
        self.resignFirstResponder()
    }
}
