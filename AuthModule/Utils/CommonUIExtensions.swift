//
//  CommonUIExtensions.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

@objc enum ColorType: Int {
    case white, black, blue, darkGray, gray, lightGray, orange, lightGreen ,green, darkGreen, lightBlack, red, pink, lightYellow, lightPink
}

@objc enum FontType: Int {
    case regular, semiBold, medium, bold
}

extension UIColor {
    
    static let customGray = UIColor(red:0.35, green:0.35, blue:0.35, alpha:1.0)
    static let customBlue = UIColor(red:0.18, green:0.41, blue:0.70, alpha:1.0)
    static let customBackgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
    static let customOrangeColor = UIColor(red:0.95, green:0.40, blue:0.13, alpha:1.0)
    static var goBlue: UIColor = UIColor(red: 0.1333333, green: 0.462745098039216, blue: 0.890196078431373, alpha: 1.0)
    static let customLightGray = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1.0)
    static var customBlack: UIColor = UIColor(red: 0.07843137254902, green: 0.094117647058824, blue: 0.137254901960784, alpha: 1.0)
}

extension UIView {
    
    func addTapGestureWithAction(_ action: Selector, target: AnyObject?) {   
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @discardableResult func setBackgroundColor(color: UIColor) -> UIView {
        self.backgroundColor = color
        return self
    }
    
    @objc func height() -> CGFloat {
        return self.frame.size.height;
    }
    
    @objc func makeCircleWithBorderColor(_ borderColor: UIColor?) {
        makeCornerRadiusWithValue(self.height() / 2, borderColor: borderColor)
    }
    
    @objc func makeCornerRadiusWithValue(_ radius: CGFloat, borderColor: UIColor? = nil) {
     
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
        if borderColor != nil {
        
            self.layer.borderColor = borderColor?.cgColor
            self.layer.borderWidth = 0.5
        }
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [5, 3]
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
}

extension UILabel {
    
    @discardableResult func setColor(color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }
    
    @discardableResult func setFont(fontType: FontType, size: CGFloat) -> UILabel {
        switch fontType {
            
        case .regular:
            self.font = UIFont.regularFontWithSize(size)
            
            
        case .semiBold:
            self.font = UIFont.semiBoldFontWithSize(size)
            
        case .medium:
            self.font = UIFont.mediumFontWithSize(size)
            
        case .bold:
            self.font = UIFont.boldFontWithSize(size)
        }
        return self
    }
    
    @discardableResult func addTapGesture(_ action: Selector, target: AnyObject?) -> UILabel {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
        return self
    }
    
    func setTextColor(_ colorType: ColorType, fontType: FontType, andFontSize size:CGFloat) {
        
        if colorType == .gray {
            self.textColor = UIColor(red:0.35, green:0.35, blue:0.35, alpha:1.0)
        } else if colorType == .blue {
            self.textColor = UIColor(red:0.18, green:0.41, blue:0.70, alpha:1.0)
        }
        
        
        self.font = UIFont.fontWithType(fontType, andSize: size)
    }
}

extension UIFont {
    @objc static func fontWithType(_ fontType: FontType = .regular, andSize size: CGFloat) -> UIFont {
        
        var font: UIFont
        
        switch fontType {
            
        case .regular:
            font = UIFont.regularFontWithSize(size)
            
        case .semiBold:
            font = UIFont.semiBoldFontWithSize(size)
            
        case .medium:
            font = UIFont.mediumFontWithSize(size)
            
        case .bold:
            font = UIFont.boldFontWithSize(size)
            
        }
        
        return font
    }
    
    static fileprivate func regularFontWithSize(_ size: CGFloat) -> UIFont {
        //return UIFont(name: "SFUIText-Regular", size: size)!
        return UIFont.systemFont(ofSize: size)
    }
    
    static fileprivate func semiBoldFontWithSize(_ size: CGFloat) -> UIFont {
        //return UIFont(name: "SFUIText-Semibold", size: size)!
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static fileprivate func mediumFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static fileprivate func boldFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
}

extension UITextField {
    
    func showAccessoryViewWithButtonTitle(_ title: String) {
        
        let width = UIApplication.shared.keyWindow!.bounds.size.width
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        view.backgroundColor = .goBlue
        view.layer.borderColor = UIColor.customLightGray.cgColor
        view.layer.borderWidth = 0.5
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: width - 80, y: 10, width: 70, height: 30)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .goBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.setFont(fontType: .regular, size: 14)
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

extension Dictionary {
    func merge(_ dict: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        
        var mutableCopy = self
        
        for (key, value) in dict {
            mutableCopy[key] = value
        }
        
        return mutableCopy
    }
}

extension Int {
    
    mutating func increment() {
        self += 1
    }
    
    mutating func decrement() {
        self -= 1
    }
}
