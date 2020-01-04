//
//  SignupViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 11/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class SignupViewController: LoginBaseViewController {

    @IBOutlet weak var continueButton: UIButton!
    var imagePickerVC: UIImagePickerController?
    
    var presenter: SignUpPresenter?
    
    var isContinueButtonEnable: Bool = false {
        didSet {
            continueButton.isUserInteractionEnabled = isContinueButtonEnable
            continueButton.backgroundColor = isContinueButtonEnable ? UIColor.customOrangeColor : UIColor.customLightGray
            continueButton.titleLabel?.textColor = isContinueButtonEnable ? UIColor.white : UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isContinueButtonEnable = false
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        if presenter?.isValidName ?? false {
            presenter?.requestSignUp()
        } else {
            AuthAlert.showInvalidNameErrorAlert(view: self)
        }
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
        isContinueButtonEnable = !text.isEmpty
    }
    
    func didDismissKeyBoard() {
        
    }
    
}
