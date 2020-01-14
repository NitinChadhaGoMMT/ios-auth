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

extension UIImageView {
    
    @discardableResult func setImage(_image: UIImage?) -> UIImageView {
        self.image = _image
        return self
    }
    
}

extension UIView {
    
    @discardableResult func setCornerRadius(radius: CGFloat) -> UIView {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        return self
    }
    
    @discardableResult func setBorder(color: UIColor, width: CGFloat) -> UIView {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        return self
    }
}

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
