//
//  EditProfileViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 05/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

enum ProfileSection: Int {
    case personalInfo
    case contactInfo
    case businessInfo
    case businessgstnInfo
    case businessadminInfo
    case addbusinessInfo
    case changePassword
    
    
    var description: String {
        switch self {
        case .personalInfo:
            return "PERSONAL INFORMATION"
        case .contactInfo:
            return "CONTACT INFORMATION"
        case .businessInfo:
            return "BUSINESS PROFILE"
        case .businessgstnInfo:
            return "COMPANY GSTN"
        case .businessadminInfo:
            return "COMPANY ADMIN"
        case .addbusinessInfo:
            return ""
        case .changePassword:
            return ""

        }
    }
}

class EditProfileViewController: UIViewController {
    
    var profileView: ProfileHeaderView!
    var isImage = false
    var sectionItem = Array<ProfileSection>()
    
    @IBOutlet weak var saveButton: UIButton!
    var isChanged = true
    typealias ImageUploadSuccessBlock = ((Bool, String?) -> Void)
    
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if #available(iOS 8.0, *) {
            self.profileTableView.tableHeaderView = profileView
        }
    }
    
    func configureUserInterface() {
        profileView = Bundle.main.loadNibNamed("ProfileHeaderView" , owner:nil , options:nil)?[0] as! ProfileHeaderView
        profileView.delegate = self
        profileView.showHideForProfile(true, update: true)
        profileTableView.contentInset = UIEdgeInsets(top: -88.0, left: 0, bottom: 0, right: 0)
        
        profileTableView.estimatedRowHeight = 50
        profileTableView.rowHeight = UITableView.automaticDimension
        if NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1 {
            self.profileTableView.tableHeaderView = profileView
        }
    }
    
    func updateTable(){
        if self.isImage == false {
            if let activeUser = UserDataManager.shared.activeUser{
                if let imageURL = activeUser.imageURL, let url = URL(string: imageURL) {
                    profileView.setProfilePicWithURL(url)
                }
            }
            self.isImage = true
        }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let isDircetFBLogin: Bool = AuthUtils.isLoginDirectlyViaFacebook()
        let canAddPassword: Bool = UserDataManager.shared.activeUser?.canAddPassword?.boolValue ?? false
        sectionItem.removeAll()
        sectionItem.append(.personalInfo)
        sectionItem.append(.contactInfo)
        
        if AuthUtils.showBusinessProfile() {
            if let businessProfileAvail = UserDataManager.shared.activeUser?.hasBusinessProfile as? Bool, businessProfileAvail == true  {
            sectionItem.append(.businessInfo)
            sectionItem.append(.businessgstnInfo)
            sectionItem.append(.businessadminInfo)
        } else {
            sectionItem.append(.addbusinessInfo)
        }
        }
        
        if (isDircetFBLogin && (canAddPassword == false)) == false {
            sectionItem.append(.changePassword)
        }
    
        self.profileTableView.reloadData()
    }

}

extension EditProfileViewController: ProfileHeaderViewDelegate {
    
    func didSignInButtonAction() {
        
    }
    
    func connectWithFbTapped() {
        
    }
    
    func addPhotoButtonTapped() {
        
    }
    
}
