//
//  SignupViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 11/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class SignupViewController: LoginBaseViewController, SignUpPresenterToViewProtocol {

    var imagePickerVC: UIImagePickerController?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var referralStatus: UILabel!
    @IBOutlet weak var successReferralImg: UIImageView!
    @IBOutlet weak var referralButton: UIButton!
    @IBOutlet weak var loginReferralImageView: UIImageView!
    
    var presenter: SignUpViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserInterface()
    }
    
    func configureUserInterface() {
        
        loginReferralImageView
            .setImage(_image: .giftIcon)
            .setCornerRadius(radius: 15.0)
        
        successReferralImg
            .setImage(_image: .tickIcon)

        AuthAnimation.flipView(view: loginReferralImageView, recursive: true)
        refreshReferralCodeView()
    }
    
    func refreshReferralCodeView() {
        
        if AuthUtils.isEmptyString(presenter?.referralCode) {
            self.referralStatus.text = FireBaseHandler.getStringFor(keyPath: .referralHeader, dbPath: .goAuthDatabase) ?? "Use a Referral Code and earn Rs. 200 goCash+"
            self.successReferralImg.isHidden = true
            self.referralButton.setTitle(.kClickHere, for: .normal)
            self.referralButton.isUserInteractionEnabled = true
        } else {
            self.referralStatus.text =  FireBaseHandler.getStringFor(keyPath: .referralSuccessHeader, dbPath: .goAuthDatabase) ?? "Referral Code applied! You earned Rs.200 goCash+"
            self.successReferralImg.isHidden = false
            self.referralButton.setTitle(presenter?.referralCode, for: .normal)
            self.referralButton.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func referralTapped(_ sender: Any) {
        presenter?.showReferralCodeInputView()
    }
}

extension SignupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell: SignUpHeaderTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        } else {
            let cell: SignUpTextInputViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? SignUpHeaderTableCell.height : SignUpTextInputViewCell.height
    }
}

extension SignupViewController: SignUpTextInputViewCellDelegate {
    
    func didChangeText(text: String) {
        presenter?.fullName = text
    }
    
    func didDismissKeyBoard() {
        
    }
    
    func didContinueTapped() {
      if presenter?.isValidName ?? false {
          presenter?.requestSignUp()
      } else {
          AuthAlert.showInvalidNameErrorAlert(view: self)
      }
    }
}

