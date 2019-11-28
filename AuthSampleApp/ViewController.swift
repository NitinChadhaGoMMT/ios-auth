//
//  ViewController.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import AuthModule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let loginController = AuthRouter.shared.createModule() {
            self.navigationController?.pushViewController(loginController, animated: true)
        }
    }
}

