//
//  UIViewController_EXT.swift
//  NCContacts
//
//  Created by Nitin Chadha on 08/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var reuseIdentifier: String { get }
}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UIViewController: ReusableView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}


extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UIView: NibLoadableView { }

extension UITableViewCell: ReusableView { }

extension Bundle {
    static func loadNib<T: NibLoadableView>() -> T? {
        if let bundle: Bundle = Bundle(identifier: "com.goibibo.AuthModule") {
            let view = bundle.loadNibNamed(T.nibName, owner: self, options: nil)?.first as? T
            return view
        }
        return nil
    }
}

extension UITableView {
    
    func registerClass<T: UITableViewCell>(_: T.Type) where T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UIStoryboard {
    
    func getViewController<T: UIViewController>() -> T? {
        return self.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T
    }
    
}

extension UIViewController {
   @objc func presentWithCurrentContext(vc:UIViewController, animated: Bool = true, completion: (()->Void)? = nil){
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: animated, completion: completion)
    }
}


extension UIView {
    @objc  func addShadowWithColor(_ color: UIColor, offset: CGSize) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = offset
        
        //self.layer.shadowPath = UIBezierPath(rect: self.bounds).CGPath
       // self.layer.shouldRasterize = true
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
}

extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func convertHTMLTagsIntoString(boldFont: UIFont = UIFont.caption1) -> NSAttributedString {
        let string = self.replacingOccurrences(of: "\\n", with: "\n")
        if string.contains("<b>") {
            let boldStrings = string.components(separatedBy: " ").filter { (aString) -> Bool in
                aString.contains("<b>")
            }
            let aHeader = string.replacingOccurrences(of: "<b>", with:"")
            let attributedString = NSMutableAttributedString(string: aHeader)
            
            for boldString in boldStrings {
                let aBoldString = boldString.replacingOccurrences(of: "<b>", with:"")
                let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
                let range = (aHeader as NSString).range(of: aBoldString)
                attributedString.addAttributes(boldFontAttribute, range: range)
            }
            return attributedString
        }
        return NSAttributedString(string: string)
    }
}
