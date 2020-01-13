//
//  SocialAccountLoginCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 06/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

class SocialAccountLoginCell: UITableViewCell {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var socialAccountsView: UIView!
    @IBOutlet weak var faceBookButton: UIButton!
    @IBOutlet weak var whatsAppButton: UIButton!
    @IBOutlet weak var socialAccountStackView: UIStackView!
    
    static let height: CGFloat = 110.0
    
    
    var isSocialLoginEnabled: Bool = false {
        didSet {
            socialAccountsView.isUserInteractionEnabled = false
            self.arrowImageView.image = isSocialLoginEnabled ? .arrowUp : .arrowDown
            if isSocialLoginEnabled {
                AuthAnimation.showEaseInCurve(view: socialAccountStackView) { [weak self] in
                    self?.socialAccountsView.isUserInteractionEnabled = true
                }
            } else {
                AuthAnimation.hideEaseInCurve(view: socialAccountStackView) { [weak self] in
                    self?.socialAccountsView.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUserInterface()
    }
    
    func configureUserInterface() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSocialAccountsVisibleState))
        self.socialAccountsView.addGestureRecognizer(tapGesture)
        
        whatsAppButton
            .setImage(image: .whatsapp)
            .setCornerRadius(radius: 18.0)
            .setBorder(color: UIColor(red:0.09, green:0.63, blue:0.38, alpha:1.0), width: 1.0)
        
        faceBookButton
            .setImage(image: .facebook)
            .setCornerRadius(radius: 18.0)
            .setBorder(color: UIColor(red:0.22, green:0.37, blue:0.66, alpha:1.0), width: 1.0)
        
        whatsAppButton.isHidden = !WhatsAppManager.shared.isWhatsAppLoginEnabled()
        
        let showLoginSocialAccounts = AuthDepedencyInjector.firebaseRemoteHandlerDelegate?.getRemoteFunctionBoolValueWithForkey(forKey: "showLoginSocialAccounts") ?? true
        
        if !showLoginSocialAccounts {
            self.socialAccountStackView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            self.socialAccountStackView.alpha = 0.0
            self.socialAccountStackView.isHidden = true
            self.arrowImageView.image = .arrowDown
        } else {
            self.arrowImageView.image = .arrowUp
        }
        isSocialLoginEnabled = showLoginSocialAccounts
    }
    
    @objc func toggleSocialAccountsVisibleState() {
        isSocialLoginEnabled.toggle()
    }
}

