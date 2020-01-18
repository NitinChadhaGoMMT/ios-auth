//
//  AuthDataProvider.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

public class AuthDataProvider {
    
    public static var userId: String? {
        return UserDataManager.shared.activeUser?.userid
    }
    
    public static var phone: String? {
        return UserDataManager.shared.activeUser?.phone
    }
    
    public static var hasPassword: Bool? {
        return UserDataManager.shared.activeUser?.hasPassword?.boolValue
    }
    
    public static var isVerified: Bool? {
        return UserDataManager.shared.activeUser?.isVerified?.boolValue
    }
    
    public static var email: String? {
        return UserDataManager.shared.activeUser?.email
    }
    
    public static var firstName: String? {
        return UserDataManager.shared.activeUser?.firstname
    }
    
    public static var title: String? {
        return UserDataManager.shared.activeUser?.title
    }
    
    public static var referralCode: String? {
        return UserDataManager.shared.activeUser?.referralCode
    }
    
    public static var branchLink: String? {
        return UserDataManager.shared.activeUser?.branchlink
    }
    
    public static var rewardsData: Data? {
        return UserDataManager.shared.activeUser?.rewardsData
    }
    
    public static var imageURL: String? {
        return UserDataManager.shared.activeUser?.imageURL
    }
    
    public static var middleName: String? {
        return UserDataManager.shared.activeUser?.middlename
    }
    
    public static var lastName: String? {
        return UserDataManager.shared.activeUser?.lastname
    }
    
    public static var isUserLoggedIn: Bool {
        return UserDataManager.shared.isLoggedIn
    }
    
    public static var previouslySynced: Bool? {
        return UserDataManager.shared.activeUser?.previouslySynced?.boolValue
    }
    
    public static var accessToken: String? {
        return AuthCache.shared.getUserDefaltObject(forKey: "access_token") as? String
    }
    
    public static var refreshToken: String? {
        return AuthCache.shared.getUserDefaltObject(forKey: "refresh_token") as? String
    }
    
    public static var emailAdmin: String? {
        return UserDataManager.shared.activeUser?.emailAdmin
    }
    
    public static var emailBusiness: String? {
        return UserDataManager.shared.activeUser?.emailBusiness
    }
    
    public static var gstin: String? {
        return UserDataManager.shared.activeUser?.gstin
    }
    
    public static var companyAddress: String? {
        return UserDataManager.shared.activeUser?.companyAddress
    }
    
    public static var companyPhone: String? {
        return UserDataManager.shared.activeUser?.companyPhone
    }
    
    public static var isFacebookLinked: Bool {
        return UserDataManager.shared.activeUser?.fbLinked?.boolValue ?? false
    }
    
    public static var mobile: String? {
        return UserDataManager.shared.activeUser?.mobile
    }
    
    public static var username: String? {
        return UserDataManager.shared.activeUser?.username
    }
    
    public static var firebaseToken: String? {
        return AuthCache.shared.getUserDefaltObject(forKey: "firebase_token") as? String
    }
    
    public static var currentTier: String {
        return UserDataManager.shared.currentTier()
    }
    
    public static var tierDict: NSDictionary? {
        return UserDataManager.shared.getTierDict()
    }
    
    public static var hasBusinessProfile: Bool? {
        return UserDataManager.shared.activeUser?.hasBusinessProfile?.boolValue
    }
    
    public static var company: String? {
        return UserDataManager.shared.activeUser?.company
    }
    
    public static var activeUserProfile: String {
        return UserDataManager.shared.getActiveUserProfile()
    }
    
    public static var isAccessTokenExpired: Bool {
        if let tokenDate = AuthCache.shared.getUserDefaltObject(forKey: "token_expiry") as? NSDate {
            let currentDate = Date()
            if tokenDate.compare(currentDate) == .orderedAscending {
                return true
            }
        }
        return false
    }
    
    public static var dob: String? {
        return UserDataManager.shared.activeUser?.dob
    }
    
    public static var getTierDict: NSDictionary? {
        if let rewardsData = UserDataManager.shared.activeUser?.rewardsData {
            if let dictionary = NSKeyedUnarchiver.unarchiveObject(with: rewardsData) as? NSDictionary {
                return dictionary
            }
        }
        return nil
    }
    
    @discardableResult public static func refreshUserInfoIfTokenExpired() -> Bool {
        let wasTokenExpired = isAccessTokenExpired
        AuthService.requestLoginWithRefreshAccessToken(successBlock: nil, errorBlock: nil)
        return wasTokenExpired
    }
    
    public static func logoutUser() {
        UserDataManager.shared.logout(type: .user)
    }
    
    public static func updateActiveUserRewardsData(tierDict: NSDictionary?) {
        DispatchQueue.main.async {
            if let activeUser = UserDataManager.shared.activeUser,let tierDict = tierDict {
                activeUser.rewardsData = NSKeyedArchiver.archivedData(withRootObject: tierDict)
            }
            DBHelper.shared.saveContext()
            
            AuthDepedencyInjector.uiDelegate?.rewardsDataUpdated()
        }
    }
    
    /*- (void)updateActiveUserRewardsData :(NSDictionary *)tierDict {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSManagedObjectContext *context = [AppDelegate sharedIns].managedObjectContext;
            
            if (tierDict && [tierDict isKindOfClass:[NSDictionary class]]) {
                self.activeUser.rewardsData = [NSKeyedArchiver archivedDataWithRootObject:tierDict];
            }
            
            [context save:nil];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RewardsDataUpdatedNotification" object:nil];
            
        });
    }*/
}
