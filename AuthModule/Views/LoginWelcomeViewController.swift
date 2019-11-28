//
//  LoginWelcomeViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

typealias LoginCompletionBlock = (Bool, NSError) -> ()

class LoginWelcomeViewController: UIViewController {

    @IBOutlet weak var constraintTableViewBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var haveInviteLabel: UILabel!
    @IBOutlet weak var enterCodeLabel: UILabel!
    @IBOutlet weak var myTable: UITableView!
    
    var presenter: LoginWelcomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserInterface()
    }
    
    func configureUserInterface() {
        haveInviteLabel
            .setColor(color: .customGray)
            .setFont(fontType: .regular, size: 14)
        
        enterCodeLabel
            .setColor(color: .customBlue)
            .setFont(fontType: .semiBold, size: 15)
    }
    
}

extension LoginWelcomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = self.presenter?.dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row] else {
            //<NITIN>fatalError() //DataSource should not be empty
            return UITableViewCell()
        }
        
        switch cellType {
            
        case .orLabelCell:
            let cell: LoginOrTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        case .newUserDetails:
            let cell: LoginNewUserDetailsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
            return cell
            
        case .fbloginCell:
            let cell: LoginFBSingupTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        case .skipNow:
            let cell: LoginSkipNowTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = self.presenter.dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        return cellType.height
    }
    
    func validateReferralCode(_ code: String, completionBlock: @escaping LoginCompletionBlock){
    }
}

extension LoginWelcomeViewController: LoginNewUserDetailsCellDelegate {
    func didSelectedNewUserLogin(with mobileNumber: String) {
        self.presenter.isFbSignup = false
        
        guard self.presenter.checkMobileValidity(mobileNumber: mobileNumber) else {
            AuthUtils.showAlert("Please enter valid mobile number")
            return
        }

        if let referralCode = presenter.referralCode, let _ = presenter.branchDictionary {
            validateReferralCode(referralCode) { (success, error) in
                
            }
        } else {
            
        }
        
    }
}
