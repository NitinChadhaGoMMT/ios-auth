    //
    //  LoginBaseViewController.swift
    //  AuthModule
    //
    //  Created by Nitin Chadha on 02/12/19.
    //  Copyright © 2019 Nitin Chadha. All rights reserved.
    //
    
import UIKit
    
class LoginBaseViewController: UIViewController {
        
    var mconnectData: MconnectData?
    lazy var isverifyMethodOtp = true
    
    @IBOutlet weak var constraintTableViewBottomSpace: NSLayoutConstraint!
    
        // MARK: Error handling
    func  handleError(_ errorData:Any?) {
            
        guard let errorObject = errorData as? ErrorData else {
            return
        }
        if errorObject.nonFieldErrorMsg != nil {
            AuthAlert.showErrorAlert(view: self, message: errorObject.nonFieldErrorMsg!)
        }  else if  errorObject.fbAccessTknMsg != nil {
            AuthAlert.showErrorAlert(view: self, message: errorObject.fbAccessTknMsg!)
        } else if  errorObject.referalErrorMsg != nil {
            AuthAlert.showErrorAlert(view: self, message: errorObject.referalErrorMsg!)
        } else if  errorObject.userNameErrorMsg != nil {
            AuthAlert.showErrorAlert(view: self, message: errorObject.userNameErrorMsg!)
        } else if  errorObject.errorMsgString != nil {
            AuthAlert.showErrorAlert(view: self, message: errorObject.errorMsgString!)
        }
    }
    
    func getSavedReferralCode() -> NSDictionary? {
        //<NITIN>
        return nil
    }
    
    func userSuccessfullyLoggedIn(){
        /*<NITIN>
        UserDataManager.sharedInstance().didUserLoginInCurrentSession = true
        FireBaseHandler.sharedInstance.getUsersLocalNotificationData()
        UserDataManager.updateLoggedInUserGoCash()
        OfflineReviewsFireBase.sharedInstance.signIn()
        RecentSearchManager.shared.performGuestUserToLoggedInUserRecentSearchMigration()*/
    }
    
    func setMConnectData(data: MconnectData?) {
        ActivityIndicator.hide(on: self.view)
        self.mconnectData = data
    }
    
    func pushController(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
    
