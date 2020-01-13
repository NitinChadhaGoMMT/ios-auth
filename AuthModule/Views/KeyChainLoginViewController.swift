//
//  KeyChainLoginViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 19/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class KeyChainLoginViewController: LoginBaseViewController {
    
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var usersDataCollectionView: UICollectionView!
    @IBOutlet weak var notNowButton: UIButton!
    
    var presenter: KeyChainLoginViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserInterface()
    }
    
    func configureUserInterface() {
        headingLabel.setTextColor(.black, fontType: FontType.bold, andFontSize: 16)
        subHeadingLabel.setTextColor(UIColor.customLightGrayColor(), fontType: FontType.regular, andFontSize: 12)
        headingLabel.text = "Single Tap Sign-In"
        subHeadingLabel.text = "Tap your Goibibo account below to sign in"
        notNowButton.setTitle("Login with different account", for: UIControl.State.normal)
        notNowButton.accessibilityIdentifier = "notNowButton"
        notNowButton.accessibilityLabel = "notNowButton"
        notNowButton.titleLabel?.setTextColor(UIColor.customBlueColor(), fontType: FontType.regular, andFontSize: 15)
        notNowButton.alpha = 0.8
        
        usersDataCollectionView.isPagingEnabled = true
        usersDataCollectionView.delegate = self
        usersDataCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = usersDataCollectionView.frame.size
        usersDataCollectionView.setCollectionViewLayout(layout, animated: true)
        
        usersDataCollectionView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.0)
        
        
        
        popUpView.makeCornerRadiusWithValue(20)
        addTapGesture()
    }
    
    func addTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tap.cancelsTouchesInView = false
        backGroundView.addGestureRecognizer(tap)
    }

    @objc func handleTap(){
        var attributes = ["Name":"Keychain","Environment":"IOS","Origin":"Client","Action":"itemTapped"]
        attributes["tappedOutside"] = ""
        AuthDepedencyInjector.AnalyticsDelegate?.pushEvent(withName: "Keychain", withAttributes: attributes)
        AuthDepedencyInjector.AnalyticsDelegate?.logCategory(event: "Keychain", dictionary: attributes)
        notNowButtonAction(UIButton())
    }
    
    @IBAction func notNowButtonAction(_ sender: UIButton) {
        AuthCache.shared.setUserDefaltBool(true, forKey: KeychainLoginHandler.shared.showLoginDataKey)
        self.dismiss(animated: true, completion: nil)
        var attributes = ["Name":"Keychain","Environment":"IOS","Origin":"Client","Action":"itemTapped"]
        attributes["currentProfileClicked"] = "0"
        AuthDepedencyInjector.AnalyticsDelegate?.pushEvent(withName: "Keychain", withAttributes: attributes)
        AuthDepedencyInjector.AnalyticsDelegate?.logCategory(event: "Keychain", dictionary: attributes)
    }
    
    func getUserId(forIndex index:Int) -> String {
        guard let dictionary = presenter?.dataSource[index] as? [String:Any] else{
            return ""
        }
        
        guard let userId = dictionary["userId"] as? String else{
            return ""
        }
        
        return userId
        
    }
}

extension KeyChainLoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeychainLoginUserCell", for: indexPath) as? KeychainLoginUserCell
        cell?.setData(data: presenter?.dataSource[indexPath.row] as? [String:Any])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modal = KeychainLoginHandler()
        modal.startLogInFLow(userid:getUserId(forIndex:indexPath.row), sender:self)
        var attributes = getAttributes()
        attributes["currentProfileClicked"] = "1"
        AuthDepedencyInjector.AnalyticsDelegate?.pushEvent(withName: "Keychain", withAttributes: attributes)
        SignInGAPManager.signinOrSignUpEvent(withEventType: .signIn, withMethod: .keyChain, withVerifyType: .keyChain, withOtherDetails: nil)
        SignInGAPManager.logGenericEventWithoutScreen(for: "loginSuccessNew", otherParams:["medium":"keychain","verificationChannel":"keychain"])
        AuthDepedencyInjector.AnalyticsDelegate?.logCategory(event: "Keychain", dictionary: attributes)
    }
    
    func getAttributes() -> [String:String]{
        return ["Name":"Keychain","Environment":"IOS","Origin":"Client","Action":"itemTapped"]
    }
}
