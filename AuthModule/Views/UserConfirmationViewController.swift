//
//  UserConfirmationViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 31/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import Contacts

class UserConfirmationViewController: LoginBaseViewController {
    
    @IBOutlet weak var topContainerview: UIView!
    @IBOutlet weak var mobileVerifiedLabel: UILabel!
    @IBOutlet weak var goIconImageView: UIImageView!
    @IBOutlet weak var goCashPlusButton: UIButton!
    @IBOutlet weak var goCashDescriptionLabel: UILabel!
    @IBOutlet weak var goCashLabelOneText: UILabel!
    @IBOutlet weak var goCashLabelTwoText: UILabel!
    @IBOutlet weak var goCashLabelThreeText: UILabel!
    @IBOutlet weak var goCashLabelFourText: UILabel!
    @IBOutlet weak var contactsHeightCOnstant: NSLayoutConstraint!
    @IBOutlet weak var contactsView: UIView!
    @IBOutlet weak var contactsImageView1: UIImageView!
    @IBOutlet weak var contactsImageView2: UIImageView!
    @IBOutlet weak var contactsImageView3: UIImageView!
    @IBOutlet weak var contactsTitleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contactsImageContainerView: UIView!
    @IBOutlet weak var goCashTitleLabel: UILabel!
    
    @objc var confirmationTitle  : String?
    
    var presenter: UserConfirmationPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUserInterface()
        getReverseProfiles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func configureUserInterface(){
        goCashPlusButton.layer.cornerRadius = 10.0
        goCashPlusButton.backgroundColor = .customOrangeColor
        self.contactsImageContainerView.isHidden = true
        activityIndicator.color = .customBlue
        mobileVerifiedLabel.setTextColor(.white, fontType: .medium, andFontSize: 15)
        mobileVerifiedLabel.isAccessibilityElement = true
        mobileVerifiedLabel.accessibilityLabel = "UserConfirmation_WelcomeLabel"
        mobileVerifiedLabel.accessibilityTraits = UIAccessibilityTraits.button
        
        let paragrapStyle = NSMutableParagraphStyle()
        paragrapStyle.paragraphSpacing = 5.0
        paragrapStyle.lineBreakMode = .byTruncatingTail
        paragrapStyle.alignment = .center
        
        let attributText = NSMutableAttributedString(attributedString: AuthUtils.getAttributedString(for: "\(presenter.dataProvider.userPersuastionTitle) \n", attributes: [NSAttributedString.Key.font: UIFont.fontWithType(.medium, andSize: 18),NSAttributedString.Key.paragraphStyle:paragrapStyle], withDefaultString: ""))
        attributText.append(AuthUtils.getAttributedString(for: presenter.dataProvider.userPersuastionSubtitle, attributes:[:], withDefaultString: ""))
        mobileVerifiedLabel.attributedText = attributText
        
        let attributText1 = NSMutableAttributedString(attributedString: AuthUtils.getAttributedString(for: presenter.dataProvider.screenTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.customBlack], withDefaultString: ""))
        self.goCashTitleLabel.attributedText =  attributText1
        self.goCashDescriptionLabel.text = presenter.dataProvider.screenSubtitle
        self.setTextFromFireBase()
    }
    
    fileprivate func setTextFromFireBase(){
        self.goCashLabelOneText.text = presenter.dataProvider.explanationTitle1
        self.goCashLabelTwoText.text = presenter.dataProvider.explanation1
        self.goCashLabelThreeText.text = presenter.dataProvider.explanationTitle2
        self.goCashLabelFourText.text = presenter.dataProvider.explanation2
        goCashPlusButton.setTitle(presenter.dataProvider.linkPhonebookButtonTitle, for: .normal)
    }
    
    func hideActivityIndicatorView(){
        activityIndicator.stopAnimating()
        contactsHeightCOnstant.constant = 0
    }
    
    func getReverseProfiles(){
        if let mobileNo = UserDataManager.shared.activeUser?.phone, mobileNo.isEmpty == false {
            presenter.getReverseProfiles()
        }
    }
    
    func reverseProfileSuccessResponse() {
        loadContactsViewWithData(profileData: presenter?.profileData)
    }
    
    func loadContactsViewWithData(profileData: ReverseProfileData?){
        
        guard let profileData = profileData else { return }
        
        if profileData.isSuccess == true, profileData.totalItems > 0 {
            activityIndicator.stopAnimating()
            self.contactsImageContainerView.isHidden = false
            self.view.layoutIfNeeded()
            
            contactsImageView1.makeCircleWithBorderColor(UIColor.white)
            contactsImageView2.makeCircleWithBorderColor(UIColor.white)
            contactsImageView3.makeCircleWithBorderColor(UIColor.white)
            
            // Change border width
            contactsImageView1.layer.borderWidth = 2.0
            contactsImageView2.layer.borderWidth = 2.0
            contactsImageView3.layer.borderWidth = 2.0
            
            let firstItem = profileData.profileItems?.first
            let username1:String = firstItem!.fname ??  ""
            var username2 = ""
            
            AuthDepedencyInjector.uiDelegate?.setImage(for: contactsImageView1, url: URL(string: firstItem?.imgURL ?? ""), placeholder: nil)
            
            if (profileData.profileItems?.count)! >= 3 {
                let secondItem = profileData.profileItems![1]
                let thirdItem = profileData.profileItems![2]
                username2 = secondItem.fname ?? ""
                AuthDepedencyInjector.uiDelegate?.setImage(for: contactsImageView2, url: URL(string: secondItem.imgURL ?? ""), placeholder: nil)
                AuthDepedencyInjector.uiDelegate?.setImage(for: contactsImageView3, url: URL(string: thirdItem.imgURL ?? ""), placeholder: nil)
            }
            else if (profileData.profileItems?.count)! == 2 {
                let secondItem = profileData.profileItems![1]
                username2 = secondItem.fname ?? ""
                AuthDepedencyInjector.uiDelegate?.setImage(for: contactsImageView2, url: URL(string: secondItem.imgURL ?? ""), placeholder: nil)
                contactsImageView3.isHidden = true
            }
            else{
                contactsImageView3.isHidden = true
                contactsImageView2.isHidden = true
            }
            
            var otherCount = profileData.totalItems
            
            if otherCount > 3 {
                otherCount = otherCount - 3
            }
            else{
                otherCount = 0
            }
            
            var nameString = presenter.dataProvider.userContactsDetail
            if username1.isEmpty == false {
                nameString = nameString.replacingOccurrences(of: "{{Friend 1}}", with: username1)
            }
            if username2.isEmpty == false {
                nameString = nameString.replacingOccurrences(of: "{{Friend 2}}", with: username2)
            }
            
            if otherCount > 0 {
                nameString = nameString.replacingOccurrences(of: "{{Friends Count}}", with: "\(otherCount)")
            }
            
            contactsTitleLabel.text = nameString
            
        }
        else{
            self.hideActivityIndicatorView()
        }
    }
    
    @IBAction func skipButtonAction(_ sender: AnyObject) {
        //... showing alert to reconfirm the user before start earning gocash via social
        SignInGAPManager.skipButtonTapped(with: .loginSKip , withOtherDetails: ["from_page":"gocashPlus"])
        let title = "Are you sure?"
        var msg = "Join millions of others who have linked their phonebooks and are enjoying bigger discounts and a more social & more informed travel experience"
        let dict = FireBaseHandler.getDictionaryFor(keyPath: .onboarding)
        if let str = dict["c_s_d_ds"] as? String {
            msg = str
        }
        
        AuthDepedencyInjector.uiDelegate?.showIBSVAlert(withTitle: title, message: msg, confirmTitle: "LINK NOW", cancelTitle: "SKIP", onCancel: {
            
            self.view.endEditing(true)
            SignInGAPManager.skipButtonTapped(with: .skipDialog , withOtherDetails: ["tap":"skip"])
            
            //<NITIN>
            //SettingSocialDataModel.sharedInstance().setPrivacy(1)
            //Utils.setPrivacyBookingContactEnabledSuccess(1)
            //Utils.setPrivacyBookingContactEnabled(1)
            //   OptionsVC.sharedInstance().actLandingPage(nil, animated: true)
            //AuthDepedencyInjector.AnalyticsDelegate?.logCategory(event: <#T##String#>, dictionary: <#T##Dictionary<String, Any>?#>)
            //IBSVAnalytics.logCategory(LOG_SOCIALGRAPH, event: WANT_GOCASHPLUS_SKIP_ANYWAYS_ALERT_BUTTON_CLICK, withParameters: nil)
            //SOCIAL_GAP
            let attributes = ["screenName": "I want goCash Plus Page"]
            AuthDepedencyInjector.AnalyticsDelegate?.pushEvent(withName: "userFlowSkip", withAttributes: attributes)
            self.userSuccessfullyLoggedInDirect()
            
        }, onConfirm: {
            SignInGAPManager.skipButtonTapped(with: .skipDialog , withOtherDetails: ["tap":"dont_skip"])
            //<NITIN>SettingSocialDataModel.sharedInstance().setPrivacy(0)
            AuthUtils.setPrivacyBookingContactEnabledSuccess(0)
            AuthUtils.setPrivacyBookingContactEnabled(0)
            AuthUtils.grantPermissionForContact()
            _ = self.determineStatus()
            AuthDepedencyInjector.AnalyticsDelegate?.logCategory(event: "WANT GOCASHPLUS PAGE EARN GOCASHPLUS CLICK", dictionary: nil)
        })
    }
    
    func determineStatus() -> Bool {
        
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized:
            DispatchQueue.main.async(execute: {
                AuthDepedencyInjector.AnalyticsDelegate?.pushEvent(withName: "goContacts_Sync_Start", withAttributes: ["syncSource" : "I Want goCash+ page"])
                self.showToastForSyncMessage()
                self.navigateToScreen()
                AuthCache.shared.setUserDefaltBool(false, forKey: "isfirebaseContactNotInitial")
                ContactsHandler.sharedInstance.isUploaded = false
                GNCibibo.uploadFirebase()
                
            })
            return true
            
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts, completionHandler: {
                (granted, err) in
                if granted == true {
                    DispatchQueue.main.async(execute: {
                        FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: "goContacts_Sync_Start", withAttributes: ["syncSource" : "I Want goCash+ page"])
                        self.showToastForSyncMessage()
                        self.navigateToScreen()
                        SharedCache.sharedInstance().setUserDefaltBool(false, forKey: FIRE_INITIAL_CONTACT_SYNC)
                        ContactsHandler.sharedInstance.isUploaded = false
                        GNCibibo.uploadFirebase()
                    })
                }
            })
            return false
            
        case .restricted:
            AuthAlert.showIBSVAlert(withTitle: "Goibibo does not have access to Contacts", msg: "You can enable access in Settings->Privacy->Contacts", confirmTitle: "Setting", cancelTitle: "Cancel", onCancel: { () -> Void in
            }, onConfirm: { () -> Void in
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                //UIApplication.shared.openURL(URL(string: "prefs:root=Settings")!)
            })
            return true
            
        case .denied:
            AuthAlert.showIBSVAlert(withTitle: "Goibibo does not have access to Contacts", msg: "You can enable access in Settings->Privacy->Contacts", confirmTitle: "Setting", cancelTitle: "Cancel", onCancel: { () -> Void in
            }, onConfirm: { () -> Void in
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                // UIApplication.shared.openURL(URL(string: "prefs:root=Settings")!)
            })
            return true
            
        @unknown default:
            AuthAlert.showIBSVAlert(withTitle: "Goibibo does not have access to Contacts", msg: "You can enable access in Settings->Privacy->Contacts", confirmTitle: "Setting", cancelTitle: "Cancel", onCancel: { () -> Void in
            }, onConfirm: { () -> Void in
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                // UIApplication.shared.openURL(URL(string: "prefs:root=Settings")!)
            })
            return true
        }
    }
    
    func showToastForSyncMessage(){
        let banner = Banner(title: nil, subtitle: "Contacts sync is in progress, we will notify you once the process is complete.", image: UIImage(named: "goLogo"), backgroundColor: UIColor.colorWithType(.blue))
        banner.dismissesOnTap = true
        banner.position = .bottom
        banner.show(duration: 5.0)
    }
    
    func navigateToScreen(){
        let index = FirebaseRemoteHelper.sharedInstance.getRemoteFunctionValue(forkey: "signup_syncscreen_cta")
        let ctaItems = FireBaseHandler.getArrayFor(keyPath: .onboardingSynchCTAs, dbPath: .goCoreDatabase)
        var ctaObj : CTAItem?
        if ctaItems.count > index {
            if let dict = ctaItems[index] as? [String:Any] {
                ctaObj = CTAItem(dict: dict)
            }
        }
        else{
            if let dict = ctaItems.first as? [String:Any] {
                ctaObj = CTAItem(dict: dict)
            }
        }
        if let tag = ctaObj?.tagId {
            OptionsVC.sharedInstance().removeAllStack()
            let notifManager = NotificationManager()
            let gd = ctaObj?.goData ?? [:]
            let dict: [String : Any] = ["gd":gd,"tg":tag]
            notifManager.processNotification(dict, isDashBoard: false)
        }
        else{
            AppRouter.navigateToEarn(goDataModel: nil, animated: false, completionBlock: nil)
        }
    }
    
    @IBAction func realGoCashAction(_ sender: AnyObject) {
        
        if let _ = self.pushcontroller {
            if (self.pushcontroller is PersonalProfileViewController) == false {
                self.userSuccessfullyLoggedIn()
                return
            }
        }
        IBSVAnalytics.logCategory(LOG_SOCIALGRAPH, event: WANT_GOCASHPLUS, withParameters: nil)
        SettingSocialDataModel.sharedInstance().setPrivacy(0)
        Utils.grantPermissionForContact()
        Utils.setPrivacyBookingContactEnabledSuccess(0)
        Utils.setPrivacyBookingContactEnabled(0)
        _ = self.determineStatus()
    }
}
