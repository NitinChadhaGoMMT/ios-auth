//
//  TempViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 30/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        textView.text = ""
        if UserDataManager.shared.isLoggedIn, let user = UserDataManager.shared.activeUser {
            for attribute in user.entity.attributesByName.keys {
                textView.text = textView.text + "\(attribute) : \(user.value(forKey: attribute) ?? "-") \n"
            }
        
            textView.text = textView.text + "\n\n\n ------------------ \n\n\n"
            
        }
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            textView.text = textView.text + "\(key) : \(UserDefaults.standard.value(forKey: key) ?? "-") \n"
        }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        UserDataManager.shared.logout(type: .user)
        AuthAlert.show(message: "USER LOGGED OUT \nRESTART THE APPLICATION")
    }
    
}
