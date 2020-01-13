//
//  KeyChainLoginPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 19/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class KeyChainLoginPresenter: KeyChainLoginViewToPresenterProtocol {
    
    var dataSource: Array<Any> = Array(KeychainLoginHandler.shared.getAllUsersInfo().values)
    
    weak var view: KeyChainLoginViewController?
    
    init() {
        sortDataArray()
    }
    
    func sortDataArray(){
        dataSource.sort { (firstElement, secondElement) -> Bool in
            if let firstDictionary = firstElement as? [String:Any],let secondDictionary = secondElement as? [String:Any] ,let firstTimeStamp = firstDictionary["timeStamp"] as? Int,let secontTimeStamp = secondDictionary["timeStamp"] as? Int{
                return firstTimeStamp > secontTimeStamp
            }
            
            return true
        }
    }
}
