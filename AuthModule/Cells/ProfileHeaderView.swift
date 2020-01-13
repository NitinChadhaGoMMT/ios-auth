//
//  ProfileHeaderView.swift
//  Goibibo
//
//  Created by Nikita Chhabra on 08/09/15.
//  Copyright © 2015 ibibo Web Pvt Ltd. All rights reserved.
//

import UIKit
@objc protocol ProfileHeaderViewDelegate: class {
    @objc optional func didSignInButtonAction()
    func connectWithFbTapped()
    @objc optional func addPhotoButtonTapped()
}

class ProfileHeaderView: UIView {
    
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var separatorView3: UIView!
    @IBOutlet weak var connectWithFacebookText: UILabel!
    @IBOutlet weak var numberOfTrips: UILabel!
    @IBOutlet weak var numberOfReviews: UILabel!
    @IBOutlet weak var numberOfPhotos: UILabel!
    @IBOutlet weak var numberOfQuestionAndAnswer: UILabel!
    @IBOutlet weak var nameOfProfile: UILabel!
    @IBOutlet weak var locationOfProfile: UILabel!
    @IBOutlet weak var separatorView1: UIView!
    @IBOutlet weak var separatorView2: UIView!
    @IBOutlet weak var connectWithFacebook: UIView!
    @IBOutlet weak var signInSignUp: UIView!
    @IBOutlet weak var signInSignUpHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var connectWithFbHeightConstraint: NSLayoutConstraint!
    weak var delegate : ProfileHeaderViewDelegate?
    @IBOutlet weak var connectToFBVerticalSpacing: NSLayoutConstraint!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var blurredProfileView: UIImageView!
    var blurEffectApplied = false
    @IBOutlet weak var addPhotoButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //addGradiantAndApplyBlurrEffect()
    }
    
    func addGradiantAndApplyBlurrEffect() {
        let gradient = CAGradientLayer()
        gradient.frame = blurredProfileView.bounds
        gradient.colors = [
            UIColor(red: 225.0, green: 225.0, blue: 225.0, alpha: 0.25).cgColor,
            UIColor(white: 0, alpha: 0.25).cgColor,
        ]
        blurredProfileView.layer.insertSublayer(gradient, at: 0)
        changePhotoButtonTitleText()
        applyBlurEffect()
        /*
         nameOfProfile.addShadowWithColor(UIColor.customLightGrayColor(), offset: CGSize.zero)
         numberOfTrips.addShadowWithColor(UIColor.customLightGrayColor(), offset: CGSize.zero)
         numberOfReviews.addShadowWithColor(UIColor.customLightGrayColor(), offset: CGSize.zero)
         numberOfPhotos.addShadowWithColor(UIColor.customLightGrayColor(), offset: CGSize.zero)
         numberOfQuestionAndAnswer.addShadowWithColor(UIColor.customLightGrayColor(), offset: CGSize.zero)
         */
    }
    
    func setProfileViewWithName(_ name: String, tripCount: Int, reviewCount: Int, photoCount: Int , qna : Int) {
        nameOfProfile.text = name
        numberOfTrips.attributedText = setAttributedLabel(tripCount , labelString: tripCount > 1 ? "Trips" : "Trip")
        numberOfReviews.attributedText = setAttributedLabel(reviewCount , labelString: reviewCount > 1 ? "Review" : "Review")
        numberOfPhotos.attributedText = setAttributedLabel(photoCount, labelString: photoCount > 1 ? "Photos" : "Photo")
        numberOfQuestionAndAnswer.attributedText = setAttributedLabel(qna, labelString: "QnA")        
    }
    
    func changePhotoButtonTitleText (){
        //
        addPhotoButton.layer.shadowColor = UIColor.black.cgColor
        addPhotoButton.layer.shadowRadius = 1.0
        addPhotoButton.layer.shadowOpacity = 1.0
        addPhotoButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        addPhotoButton.layer.masksToBounds = false
        
        if let activeUser = UserDataManager.shared.activeUser {
            if let fblinked = activeUser.fbLinked , fblinked == true || activeUser.imageURL != nil {
                addPhotoButton.setTitle("Change Photo", for: UIControl.State())
            }
            else{
                addPhotoButton.setTitle("Add Photo", for: UIControl.State())
            }
        }
    }
    
    func setAttributedLabel(_ number : Int , labelString : String)->NSMutableAttributedString{
        let titleAttribute = NSMutableAttributedString(string:"\(number)\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white ,NSAttributedString.Key.font :  UIFont(name: "HelveticaNeue", size: 22)! ])
        
        let subtitleAttribute = NSMutableAttributedString(string:"\(labelString)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        subtitleAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue", size: 11)!, range: NSRange(location: 0, length: labelString.count))
        
        let titleAttributedString = NSMutableAttributedString()
        titleAttributedString.append(titleAttribute)
        titleAttributedString.append(subtitleAttribute)
        return titleAttributedString
    }
    
    func showHideForProfile(_ logged : Bool , update : Bool){
        /* if let activeUser = UserDataManager.sharedInstance().activeUser , let fblinked = activeUser.fbLinked{
         connectWithFacebook.isHidden = (fblinked.boolValue || FBSDKAccessToken.current() != nil)
         connectWithFbHeightConstraint.constant = (fblinked.boolValue || FBSDKAccessToken.current() != nil) ? 0.0 : 76
         }
         else{
         connectWithFacebook.isHidden = (false || FBSDKAccessToken.current() != nil)
         connectWithFbHeightConstraint.constant = (false || FBSDKAccessToken.current() != nil) ? 0.0 : 76
         }
         */
        connectWithFacebook.isHidden = true
        connectWithFbHeightConstraint.constant = 0.0
        
        if update {
            numberOfPhotos.isHidden = true
            numberOfReviews.isHidden = true
            numberOfTrips.isHidden = true
            nameOfProfile.isHidden = true
            signInSignUp.isHidden = true
            numberOfQuestionAndAnswer.isHidden = true
            separatorView3.isHidden = true
            separatorView1.isHidden = true
            separatorView2.isHidden = true
            viewShadow.isHidden = true
            signInSignUpHeightConstraint.constant = 0
            addPhotoButton.isHidden = false
            connectWithFacebookText.text = "Connect With Facebook"
            return
        }
        
        if logged {
            numberOfPhotos.isHidden = false
            numberOfReviews.isHidden = false
            numberOfTrips.isHidden = false
            nameOfProfile.isHidden = false
            numberOfQuestionAndAnswer.isHidden = false
            connectWithFacebook.isHidden = true
            signInSignUp.isHidden = true
            separatorView1.isHidden = false
            separatorView2.isHidden = false
            separatorView3.isHidden = false
            viewShadow.isHidden = false
            addPhotoButton.isHidden = true
            connectWithFbHeightConstraint.constant = 0
            signInSignUpHeightConstraint.constant = 0
            connectWithFacebookText.text = "Connect With Facebook"
            
        }
        else{
            numberOfPhotos.isHidden = true
            numberOfReviews.isHidden = true
            numberOfTrips.isHidden = true
            nameOfProfile.isHidden = true
            separatorView1.isHidden = true
            separatorView2.isHidden = true
            separatorView3.isHidden = true
            viewShadow.isHidden = true
            addPhotoButton.isHidden = true
            
            numberOfQuestionAndAnswer.isHidden = true
            connectWithFbHeightConstraint.constant = 0.0
            signInSignUpHeightConstraint.constant = 60
            signInSignUp.isHidden = false
            connectWithFacebookText.text = "Login With Facebook"
        }
    }
    
    func setProfilePicWithURL(_ photo:URL?) {
        changePhotoButtonTitleText()
        if let profileDisplayPicURL = photo , !profileDisplayPicURL.absoluteString.isEmpty{
            ImageHelper.setImage(for: self.profilePic, url: profileDisplayPicURL, placeholder: UIImage(named: "dummyProfilePic.png.png"))
            ImageHelper.setImage(for: self.blurredProfileView, url: profileDisplayPicURL, placeholder: UIImage(named: "dummyProfilePic.png.png"), completionBlock: {
                self.applyBlurEffect()
            })
        }
        else {
            profilePic.image = .dummyProfilePic
            blurredProfileView.image = .dummyProfilePic
            self.applyBlurEffect()
        }
    }
    
    func setProfilePicWithURLWithoutBlur(_ photo:URL?) {
        changePhotoButtonTitleText()
        if let profileDisplayPicURL = photo , !profileDisplayPicURL.absoluteString.isEmpty{
            ImageHelper.setImage(for: self.profilePic, url: profileDisplayPicURL, placeholder: .dummyProfilePic)
            ImageHelper.setImage(for: self.blurredProfileView, url: profileDisplayPicURL, placeholder: .dummyProfilePic)
        }
        else {
            profilePic.image = .dummyProfilePic
            blurredProfileView.image = .dummyProfilePic
        }
    }
    
    @IBAction func fbConnect(_ sender: AnyObject?) {
        delegate?.connectWithFbTapped()
    }
    
    @IBAction func handleSignInButtonAction(_ sender: AnyObject) {
        delegate?.didSignInButtonAction?()
    }
    
    @IBAction func didAddOrChangePhotoButtonTap(_ sender: AnyObject) {
        delegate?.addPhotoButtonTapped?()
        changePhotoButtonTitleText()
    }
    
    //MARK: Applr Blur Effect
    func applyBlurEffect() {
        // create effect
        if blurEffectApplied == false {
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = CGRect(x: blurredProfileView.frame.origin.x, y: blurredProfileView.frame.origin.y, width: UIScreen.main.bounds.size.width, height: blurredProfileView.frame.size.height)
            
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
            vibrancyEffectView.frame = blurredProfileView.frame
            
            // add the effect view to the image view
            blurredProfileView.addSubview(blurEffectView)
            blurredProfileView.addSubview(vibrancyEffectView)
            blurEffectApplied = true
        }
    }
}
