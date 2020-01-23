//
//  Reusable_Extensions.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
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
