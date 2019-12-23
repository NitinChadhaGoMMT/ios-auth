//
//  BaseProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 19/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

protocol InteractorBaseProtocol: class {
    
    func checkForMobileConnectAPI(completionBlock: @escaping (MconnectData?) -> ())
    
    func verifymConnectDataWithMobileNo(_ mobileNo: String)
}

protocol LoginBaseProtocol: class {
    
    var isverifyMethodOtp: Bool { get set }
    
    func showActivityIndicator()
    
    func hideActivityIndicator()
    
    func setMConnectData(data: MconnectData)
    
    func push(screen: UIViewController)
    
    func handleError(_ errorData:Any?)
}
