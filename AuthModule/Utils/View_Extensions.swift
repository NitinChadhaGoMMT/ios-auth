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
        let view = self.main.loadNibNamed(T.nibName, owner: self, options: nil)?.first as? T
        return view
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
        //<NITIN>
        /*if #available(iOS 8.0, *) {
            AppDelegate.sharedIns().baseNavigationVC.providesPresentationContextTransitionStyle = true
            AppDelegate.sharedIns().baseNavigationVC.definesPresentationContext = true
            vc.modalPresentationStyle = .overCurrentContext
        } else {
            AppDelegate.sharedIns().baseNavigationVC.modalPresentationStyle =  .currentContext
        }*/
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
}
