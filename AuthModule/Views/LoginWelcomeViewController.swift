//
//  LoginWelcomeViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

typealias LoginCompletionBlock = (Bool, NSError) -> ()

class LoginWelcomeViewController: LoginBaseViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var enterCodeLabel: UILabel!
    @IBOutlet weak var haveInviteLabel: UILabel!
    @IBOutlet weak var constraintTableViewBottomSpace: NSLayoutConstraint!
    
    var presenter: LoginWelcomePresenter!
    
    var isUserLoggingIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.performInitialConfiguration()
        configureUserInterface()
    }
    
    func configureUserInterface() {
        haveInviteLabel
            .setColor(color: .customGray)
            .setFont(fontType: .regular, size: 14)
        
        enterCodeLabel
            .setColor(color: .customBlue)
            .setFont(fontType: .semiBold, size: 15)
            .addTapGesture(#selector(enterReferralCodeTapped), target: self)
        
        resetReferralCode()
    }
    
    @objc func enterReferralCodeTapped() {
        let alert = AuthAlert.showReferralCodeAlert(view: self, success: { [weak self] (referralCode) in
            self?.enterCodeLabel.text = referralCode ?? ""
            self?.presenter?.validateReferralCode(_referralCode: referralCode!, isBranchFlow: false)
        }) {
            
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetReferralCode(){
        presenter.resetReferralCode()
        if let referralCode = presenter.referralCode {
            haveInviteLabel.text = "Referral Code"
            enterCodeLabel.text = referralCode
            enterCodeLabel.isUserInteractionEnabled = false
        } else {
            haveInviteLabel.text = "Have a referral code?"
            enterCodeLabel.text = "Enter Code"
            enterCodeLabel.isUserInteractionEnabled = true
        }
        myTable.reloadData()
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
        
        guard let cellType = self.presenter?.dataSource[indexPath.section][indexPath.row] else {
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
        ActivityIndicator.show(on: self.view)
        presenter.validateReferralCode(_referralCode: self.presenter.referralCode, isBranchFlow: true)
    }
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData?) {
        hideActivityIndicator()
        resetReferralCode()
        
        if isUserLoggingIn {
            verifyMobileWithNumber(presenter.currentMobileNumber!)
        }
        isUserLoggingIn = false
    }
    
    func verifyReferralRequestFailed(response: ErrorData?) {
        hideActivityIndicator()
        handleError(response)
        resetReferralCode()
    }
    
    func verifyMobileNumberRequestFailed(error: ErrorData?) {
        hideActivityIndicator()
        handleError(error)
    }
    
    func verifyMobileWithNumber(_ mobileNo:String) {
        
        self.view.endEditing(true)
        
        if presenter.isFbSignup {
            //self.requestFBOTPWithMobileNo(mobileNo)
            return
        }
        
        ActivityIndicator.show(on: self.view)
        presenter.verifyMobileNumber(number: mobileNo)
    }
    
    func hideActivityIndicator() {
        ActivityIndicator.hide(on: self.view)
    }
}

extension LoginWelcomeViewController: LoginNewUserDetailsCellDelegate {
    func didSelectedNewUserLogin(with mobileNumber: String) {
        self.presenter.isFbSignup = false
        
        guard self.presenter.checkMobileValidity(mobileNumber: mobileNumber) else {
            AuthUtils.showAlert(on: self, message: "Please enter valid mobile number")
            return
        }

        isUserLoggingIn = true
        presenter.currentMobileNumber = mobileNumber
        
        if let referralCode = presenter.referralCode, let _ = presenter.branchDictionary {
            validateReferralCode(referralCode) { [weak self] (success, error) in
                self?.verifyMobileWithNumber(mobileNumber)
            }
        } else {
            verifyMobileWithNumber(mobileNumber)
        }
        
    }
}
