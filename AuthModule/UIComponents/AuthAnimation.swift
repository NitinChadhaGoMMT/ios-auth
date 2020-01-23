//
//  AuthAnimation.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

struct AuthAnimation {
    
    static func hideEaseInCurve(view: UIView, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            view.alpha = 0.0
        }, completion: {(_) in
            view.isHidden = true
            if let completion = completion {
                completion()
            }
        })
    }
    
    static func showEaseInCurve(view: UIView, completion: (() -> Void)? = nil)  {
        view.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
             view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
             view.alpha = 1.0
        }, completion: {(_) in
            if let completion = completion {
                completion()
            }
        })
     }
    
    static func easeInOutAnimation(view: UIView, show: Bool, completion: (() -> Void)? = nil) {
        
        if show { view.isHidden = false }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            view.transform = show ? CGAffineTransform(scaleX: 1.0, y: 1.0) : CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            view.alpha = show ? 1.0 : 0.0
        }, completion: {(_) in
            
            if !show { view.isHidden = true }
            
            if let completion = completion {
                completion()
            }
        })
        
    }
    
    static func flipView(view: UIView, recursive: Bool = true) {
        UIView.transition(with: view, duration: 2.0, options: .transitionFlipFromLeft, animations: {
        }, completion: { (finished) in
            if finished && recursive {
                flipView(view: view, recursive: recursive)
            }
        })
    }
}
