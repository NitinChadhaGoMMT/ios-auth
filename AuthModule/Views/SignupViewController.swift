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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.setTitleColor(.white, for: .normal)
    }
}

extension SignupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellType = self.presenter?.dataSource[indexPath.row] else {
            return UITableViewCell()
        }
        
        if cellType == .firstName {
            let cell: SignUpTextInputViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
            return cell
        } else {
            let cell: SignUpHeaderTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = self.presenter?.dataSource[indexPath.row] else {
            return 44.0
        }
        
        return cellType.height
    }
}

extension SignupViewController: SignUpTextInputViewCellDelegate {
    
    func didChangeText(text: String) {
        
    }
    
    func didDismissKeyBoard() {
        
    }
    
}
