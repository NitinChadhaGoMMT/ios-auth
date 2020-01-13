//
//  OnboardingWelcomeContentController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 08/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

class OnboardingWelcomeContentController: UIViewController {

    @IBOutlet weak var getStartedImageView: UIImageView!
    @IBOutlet weak var getStartedHeader: UILabel!
    @IBOutlet weak var getStartedSubHeader: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var dataSource: OnboardingPresenter.OnboardingDataModel!
    var pagesCount: Int!
    
    var presentNextController: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialConfiguration()
    }
    
    fileprivate func doInitialConfiguration() {
        
        self.getStartedHeader
            .setColor(color: .black)
            .setFont(fontType: .title1)
            
        self.getStartedSubHeader
            .setFont(fontType: .label1)
            .setColor(color: .gray)
        
        self.nextButton
            .setFont(font: .title3)
            .setCornerRadius(radius: 25.0)
        
        self.skipButton
            .setFont(font: .label1)
            
            
        self.pageControl.currentPage = dataSource.pageIndex
        
        // Set Values
        self.getStartedImageView.image = dataSource.image
        self.getStartedHeader.attributedText = NSAttributedString(string: dataSource.header)
        self.getStartedSubHeader.attributedText =  NSAttributedString(string: dataSource.subHeader)
        
        self.nextButton.setTitle(dataSource.pageIndex == pagesCount - 1 ? Constants.kGetStarted : Constants.kNext, for: .normal)
        self.skipButton.isHidden = dataSource.pageIndex == pagesCount - 1
    }
    
    @IBAction func getStartedTapped(_ sender: Any) {
        if dataSource.pageIndex ==  pagesCount - 1 {
          self.invokeLogin()
        } else {
            presentNextController?(dataSource.pageIndex)
        }
    }
    
    @IBAction func skipTapped(_ sender: Any) {
        self.invokeLogin()
    }
    
    fileprivate func invokeLogin() {
        AuthUtils.removeMobileKey()
        if let vc = AuthRouter.shared.createModule() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func presentNextScreen(completion: @escaping (Int) -> Void) {
        presentNextController = completion
    }
}
