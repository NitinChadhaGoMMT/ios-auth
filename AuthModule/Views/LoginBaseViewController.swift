    //
    //  LoginBaseViewController.swift
    //  AuthModule
    //
    //  Created by Nitin Chadha on 02/12/19.
    //  Copyright © 2019 Nitin Chadha. All rights reserved.
    //
    
import UIKit
    
    class LoginBaseViewController: UIViewController, LoginBaseProtocol {
        
    var mconnectData: MconnectData?
        
    var baseNavigationController: UINavigationController? {
        return self.navigationController
    }
    
    @IBOutlet weak var constraintTableViewBottomSpace: NSLayoutConstraint!
    
        // MARK: Error handling
    func  showError(_ errorData:Any?) {
            
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
        } else {
            AuthAlert.showErrorAlert(view: self, message: "Something wrent wrong. Please try again later.")
        }
    }
    
    func userSuccessfullyLoggedIn(){
        UserDataManager.shared.didUserLoginInCurrentSession = true
        /*<NITIN>
        FireBaseHandler.sharedInstance.getUsersLocalNotificationData()
        UserDataManager.updateLoggedInUserGoCash()
        OfflineReviewsFireBase.sharedInstance.signIn()
        RecentSearchManager.shared.performGuestUserToLoggedInUserRecentSearchMigration()*/
        //AuthAlert.show(message: "User LoggedIn Successfully")
        AuthRouter.goToHomePage(vc: self)
    }
    
    func signUpSuccessfully() {
        //<NITIN> UserTraitManager.shared.updateData(forAttributes: ["isNewUser":true])
    }
    
    func userSuccessfullyLoggedInDirect() {
        
        self.logInSuccessfully()
        AuthRouter.shared.finishLoginFlow(error: nil)
    }
    
    func logInSuccessfully(){
        //<NITIN>
        UserDataManager.shared.didUserLoginInCurrentSession = true
        //FireBaseHandler.sharedInstance.getUsersLocalNotificationData()
        UserDataManager.updateLoggedInUserGoCash()
        //OfflineReviewsFireBase.sharedInstance.signIn()
        //RecentSearchManager.shared.performGuestUserToLoggedInUserRecentSearchMigration()
    }
    
    func setMConnectData(data: MconnectData) {
        self.mconnectData = data
        addMconnectView()
    }
    
    func addMconnectView() {
        //override this method
    }
    
    func removeBranchReferralData(){
        AuthUtils.removeBranchReferCode()
    }
    
    func pushController(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showActivityIndicator() {
        ActivityIndicator.show(on: self.view)
    }
    
    func hideActivityIndicator() {
        ActivityIndicator.hide(on: self.view)
    }
    
    func push(screen: UIViewController) {
        self.navigationController?.pushViewController(screen, animated: true)
    }
        
    func present(screen: UIViewController) {
        presentWithCurrentContext(vc: screen)
    }
        
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
        
    func verifymConnectDataWithMobileNo(_ mobileNo: String, isFbSignup: Bool, referralCode: String){
        self.view.endEditing(true)
        AuthService.verifyMobileWithMconnect(withMobile: mobileNo, mconnectData: self.mconnectData!, isFBSignUp: isFbSignup, referralCode: referralCode, success: { [weak self] (responseData) in
            self?.handleMConnectSuccessData(responseData, mobileNo:mobileNo)
        }) { [weak self](error) in
            self?.handleMConnectFailure(mobileNo: mobileNo)
        }
    }
    
    func handleMConnectSuccessData(_ responseData: Any?, mobileNo: String){
        //over ride this function to process
    }
    
    func handleMConnectFailure(mobileNo: String){
        //over ride this to call otp request in mconnect failure
    }
}
    
