//
//  UIViewController_EXT.swift
//  NCContacts
//
//  Created by Nitin Chadha on 08/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

extension UIViewController {
   @objc func presentWithCurrentContext(vc:UIViewController, animated: Bool = true, completion: (()->Void)? = nil){
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: animated, completion: completion)
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
    
    @objc  func addShadowWithColor(_ color: UIColor, offset: CGSize) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = offset
    }
    
    func addCenterConstraints(toView view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
     @objc @discardableResult func addTopConstraint(with constant: CGFloat, toView: UIView) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top, multiplier: 1.0, constant: constant)
        toView.addConstraint(constraint)
        
        return constraint
    }
    
     @objc @discardableResult func addBottomConstraint(with constant: CGFloat, toView: UIView) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom, multiplier: 1.0, constant: constant)
        toView.addConstraint(constraint)
        
        return constraint
    }

    @objc  @discardableResult func addLeadingConstraint(with constant: CGFloat, toView: UIView) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading, multiplier: 1.0, constant: constant)
        toView.addConstraint(constraint)
        
        return constraint
    }
    
     @objc @discardableResult func addTrailingConstraint(with constant: CGFloat, toView: UIView) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: 1.0, constant: constant)
        toView.addConstraint(constraint)
        
        return constraint
    }
    
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
