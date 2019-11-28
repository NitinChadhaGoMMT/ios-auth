//
//  LoginWelcomeHeaderCell.swift
//  AuthModule
//
//  Created by Nitin Chadha on 26/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

fileprivate class LoginWelcomeDataModel {
    var titleSubtitleText: NSAttributedString?
    var bgColor: UIColor = .customBlue
    var logoImage: String?
    var bgImage: String?
    var bgCornerImage: String?
    var branchData: [String:Any]?
    
    var type: Int = 0
    
    init(dict: [String:Any]) {
        let attributedText = NSMutableAttributedString()
        if let title = dict["title"] as? String {
            attributedText.append(getAttributedText(text: title, font: UIFont.fontWithType(.medium, andSize: 14)))
            attributedText.append(getAttributedText(text: "\n", font: UIFont.fontWithType(.bold, andSize: 10)))
        }
        if let subtitle = dict["subtitle1"] as? String {
            attributedText.append(getAttributedText(text: subtitle, font: UIFont.fontWithType(.bold, andSize: 18)))
        }
        if let subtitle = dict["subtitle2"] as? String {
            attributedText.append(getAttributedText(text: "\n", font: UIFont.fontWithType(.regular, andSize: 10)))
            attributedText.append(getAttributedText(text: subtitle, font: UIFont.fontWithType(.regular, andSize: 14)))
        }
        titleSubtitleText = attributedText
        self.logoImage = dict["logoImage"] as? String
        self.bgImage = dict["bgImage"] as? String
        self.bgCornerImage = dict["bgCornerImage"] as? String
        if let value = dict["type"] as? Int {
            self.type = value
        }
        if let branchDict = dict["branchData"] as? [String:Any] {
            self.branchData = branchDict
            self.type = 1
            self.fillDataFromBranchDict(dict: branchDict)
        }
    }
    
    func fillDataFromBranchDict(dict: [String:Any]){
        let attributedText = NSMutableAttributedString()
        if let name = dict["username"] as? String, name.count > 0 {
            attributedText.append(getAttributedText(text: name, font: UIFont.fontWithType(.semiBold, andSize: 17)))
        }
        else{
            attributedText.append(getAttributedText(text: "Your friend", font: UIFont.fontWithType(.semiBold, andSize: 17)))
        }
        attributedText.append(getAttributedText(text: " has invited you.\n", font: UIFont.fontWithType(.medium, andSize: 17)))
        var title = "Signup to claim your goCash+"
        var subtitle = "Sync your contacts to earn goCash+ each time your contacts make a booking."
        let dict = FireBaseHandler.getDictionaryFor(keyPath: .onboarding)
        if let str = dict["wp_r_t"] as? String {
            title = str
        }
        if let str = dict["wp_r_st"] as? String {
            subtitle = str
        }
        
        attributedText.append(getAttributedText(text: title, font: UIFont.fontWithType(.regular, andSize: 14)))
        attributedText.append(getAttributedText(text: "\n", font: UIFont.fontWithType(.regular, andSize: 14)))
        attributedText.append(getAttributedText(text: subtitle, font: UIFont.fontWithType(.regular, andSize: 12)))
        titleSubtitleText = attributedText
    }
    
    func getAttributedText(text:String, font: UIFont) -> NSMutableAttributedString{
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 4.0
        let attributedText : NSMutableAttributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle:paragraphStyle])
        return attributedText
    }
}

fileprivate class LoginWelcomeHeaderViewModel {
    
    var dataSource = [LoginWelcomeDataModel]()
    var branchDict: NSDictionary?
    var isSkipEnabled : Bool = true
    
    init() {
        configureDataSource()
    }
    
    func configureDataSource() {
        var itemData:[Any]?
        
        itemData = getFilteredCellsFromAuthParams()
        
        itemData?.append(FireBaseHandler.getArrayFor(keyPath: .onboardingWelcomeTutorial, dbPath: .goCoreDatabase))
        
        if let items = itemData as? [[String:Any]] {
            dataSource.removeAll()
            
            for item in items {
                dataSource.append(LoginWelcomeDataModel(dict: item))
            }
            
            if branchDict != nil {
                let dataModel = LoginWelcomeDataModel(dict: ["branchData":branchDict!])
                var tempCellArray = dataSource
                for (index,cell) in dataSource.enumerated() {
                    if cell.type == 1 {
                        tempCellArray[index] = dataModel
                        break
                    }
                }
                dataSource = tempCellArray
            }
            
        }
    }
    
    func getFilteredCellsFromAuthParams() -> Array<Any> {
        
        guard let authParams = SharedCache.shared.getUserDefaltObject(forKey: "auth_params") as? Dictionary<String, Any> else {
            return Array<Any>()
        }
        
        let platform = authParams["platform"] as? String
        let source = authParams["source"] as? String
        let lob = authParams["lob"] as? String
        let subLob = authParams["sub_lob"] as? String
        let itemData = FireBaseHandler.getArrayFor(keyPath: .onboardingInstallSourceTutorial, dbPath: .goCoreDatabase)
        var filteredArray = Array<Any>()
        
        for item in itemData {
            
            var shouldFilterItem = false
            
            guard let item = item as? Dictionary<String, Any> else {
                continue
            }
            
            if let itemPlatform = item["platform"] as? Array<String> {
                guard let platform = platform, itemPlatform.contains(platform) else { continue }
                shouldFilterItem = true
            }
            
            if let itemSource = item["source"] as? Array<String> {
                guard let source = source, itemSource.contains(source) else { continue }
                shouldFilterItem = true
            }
            
            if let itemLob = item["lob"] as? Array<String> {
                guard let lob = lob, itemLob.contains(lob) else { continue }
                shouldFilterItem = true
            }
            
            if let itemSubLob = item["sub_lob"] as? Array<String> {
                guard let subLob = subLob, itemSubLob.contains(subLob) else { continue }
                shouldFilterItem = true
            }
            
            if shouldFilterItem {
                filteredArray.append(item)
            }
        }
        
        return filteredArray
    }
    
    
}

class LoginWelcomeHeaderCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var timer: Timer?
    fileprivate var viewModel = LoginWelcomeHeaderViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUserInterface()
    }
    
    func configure(dictionary: NSDictionary?) {
        if let dictionary = dictionary {
            viewModel.branchDict = dictionary
        }
        self.pageControl.numberOfPages = viewModel.dataSource.count
    }
    
    func configureUserInterface() {
        collectionView.backgroundColor = .customBlue
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        startTimer()
    }
    
    func resetTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func startTimer() {
        resetTimer()
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(scrollCollectionViewPage), userInfo: nil, repeats: true)
    }
    
    func configureCellWithDetails(details: AnyObject?) {
        if let dic = details as? NSDictionary {
            viewModel.branchDict = dic
        }
        viewModel.configureDataSource()
        self.pageControl.numberOfPages = viewModel.dataSource.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            resetTimer()
        }
        super.willMove(toSuperview: newSuperview)
    }
    
    override func prepareForReuse() {
        resetTimer()
    }
    
    @IBAction func pageControlTapped(){
        self.collectionView?.scrollToItem(at: IndexPath(item: self.pageControl.currentPage, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    @objc func scrollCollectionViewPage(){
        if self.pageControl.currentPage + 1 < viewModel.dataSource.count {
            self.collectionView?.scrollToItem(at: IndexPath(item: self.pageControl.currentPage + 1, section: 0), at: .centeredHorizontally, animated: true)
        }
        else{
            self.collectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}
