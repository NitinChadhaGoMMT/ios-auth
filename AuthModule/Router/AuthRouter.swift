//
//  AuthRouter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 21/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

public class AuthRouter {

    public static let shared = AuthRouter()
    
    var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Auth",bundle: Bundle(identifier: "com.goibibo.Goibibo.AuthModule.AuthModule"))
    }
    
    public func createModule() -> UIViewController? {
        
        guard let view: LoginWelcomeViewController = mainstoryboard.getViewController() else {
            return nil
        }
        
        let presenter = LoginWelcomePresenter()
        let interactor = LoginWelcomeInteractor()
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        return view
    }
    
}
