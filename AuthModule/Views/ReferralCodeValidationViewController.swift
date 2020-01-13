//
//  ReferralCodeValidationViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

class ReferralCodeValidationViewController: LoginBaseViewController, ReferralCodeValidationPresenterToViewProtocol {
    
    @IBOutlet weak var primaryImageView: UIImageView!
    @IBOutlet private weak var progressView: UIView!
    @IBOutlet private weak var backgroundProgressView: UIView!
    
    var timer = Timer()
    var newOrigin = CGPoint.zero
    var branchDict: NSDictionary?
    var screenTimer: DispatchTime?
    
    var presenter: ReferralCodeValidationPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        primaryImageView.image = .referralHeader
        scheduledTimerWithTimeInterval(for: true)
        
        newOrigin = self.progressView.frame.origin
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.validateReferralCodeFromDeepLink()
    }
    
    func referralCodeFailure() {
        AuthAlert.showToastMessage(on: self, message: "Invalid Code. Add this later on.", duration: 4.0, position: "bottom")
    }
    
    func referralCodeSuccess() {
        AuthAlert.showToastMessage(on: self, message: "Referral Code applied!", duration: 4.0, position: "bottom")
    }
}


extension ReferralCodeValidationViewController {
    //Progress view  Animation
    
    func scheduledTimerWithTimeInterval(for toMotion:Bool) {
        timer.invalidate()
        
        if toMotion {
            timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(toAnimateView), userInfo: nil, repeats: true)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(froAnimateView), userInfo: nil, repeats: true)
        }
    }
    
    @objc fileprivate func toAnimateView() {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
            let view:UIView = self.progressView
            view.frame.origin = self.newOrigin
        }, completion: { (success) in
            if self.newOrigin.x + 56 >= self.backgroundProgressView.frame.size.width {
                self.scheduledTimerWithTimeInterval(for: false)
            } else {
                self.newOrigin.x = self.newOrigin.x + 10
            }
        })
    }
    
    
    @objc fileprivate func froAnimateView() {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
            let view:UIView = self.progressView
            view.frame.origin = self.newOrigin
        }, completion: { (success) in
            if self.newOrigin.x + 56 <= self.backgroundProgressView.frame.origin.x {
                self.scheduledTimerWithTimeInterval(for: true)
            } else {
                self.newOrigin.x = self.newOrigin.x - 10
            }
        })
    }
}
