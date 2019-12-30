//
//  KeyChainLoginViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 19/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class KeyChainLoginViewController: UIViewController {
    
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var usersDataCollectionView: UICollectionView!
    @IBOutlet weak var notNowButton: UIButton!
    
    var presenter: KeyChainLoginPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserInterface()
    }
    
    func configureUserInterface() {
        headingLabel.setTextColor(ColorType.black, fontType: FontType.bold, andFontSize: 16)
        subHeadingLabel.setTextColor(ColorType.lightGray, fontType: FontType.regular, andFontSize: 12)
        headingLabel.text = "Single Tap Sign-In"
        subHeadingLabel.text = "Tap your Goibibo account below to sign in"
        notNowButton.setTitle("Login with different account", for: UIControl.State.normal)
        notNowButton.accessibilityIdentifier = "notNowButton"
        notNowButton.accessibilityLabel = "notNowButton"
        notNowButton.titleLabel?.setTextColor(ColorType.blue, fontType: FontType.regular, andFontSize: 15)
        notNowButton.alpha = 0.8
        
        usersDataCollectionView.isPagingEnabled = true
        usersDataCollectionView.delegate = self
        usersDataCollectionView.dataSource = self
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
        //<NITIN>FirebaseAnalyticsHandler.sharedInstance.pushEvent(withName: "Keychain", withAttributes: attributes)
        AuthDepedencyInjector.AnalyticsDelegate?.logCategory(event: "Keychain", dictionary: attributes)
    }
}

extension KeyChainLoginViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
}
