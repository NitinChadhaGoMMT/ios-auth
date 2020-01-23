//
//  ActivityIndicator.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

struct ActivityIndicator {
    
    static var activityIndicator: UIActivityIndicatorView?
    
    static func show(on view: UIView?, withMessage message: String? = nil) {
        
        guard let view = view else { return }
        
        AuthDepedencyInjector.uiDelegate?.showActivityIndicator(on: view)
    }
    
    static func hide(on view: UIView?) {
        
        guard let view = view else { return }
        
        AuthDepedencyInjector.uiDelegate?.hideActivityIndicator(from: view)
    }
    
    static func showNative(on view: UIView?) {
        
        guard let view = view else { return }
        
        activityIndicator = nil
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.addCenterConstraints(toView: view)
        view.addSubview(activityIndicator!)
        activityIndicator?.startAnimating()
    }
    
    static func hideNative() {
        
        guard let _ = activityIndicator else {
            return
        }
        
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
}
