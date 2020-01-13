//
//  OnboardingWelcomeViewController.swift
//  AuthModule
//
//  Created by Nitin Chadha on 08/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

class OnboardingPresenter {
    
    var pagesCount = 3
    
    struct OnboardingDataModel {
        let pageIndex: Int
        let header: String
        let subHeader: String
        let image: UIImage?
    }
    
    let dataSource = [
        OnboardingDataModel(pageIndex: 0,header: Constants.kFirstHeader, subHeader: Constants.kFirstSubHeader, image: .onboardingPic1),
        OnboardingDataModel(pageIndex: 1,header: Constants.kSecondHeader, subHeader: Constants.kSecondSubHeader, image: .onboardingPic2),
        OnboardingDataModel(pageIndex: 2,header: Constants.kThreeHeader, subHeader: Constants.kThreeSubHeader, image: .onboardingPic3)
    ]
}

class OnboardingWelcomeContainer: UIPageViewController {

    var presenter = OnboardingPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let firstVC = self.getViewController(withIndex: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

extension OnboardingWelcomeContainer: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageIndex = (viewController as? OnboardingWelcomeContentController)?.dataSource.pageIndex ?? 0
        
        if pageIndex == 0 {
            return nil
        }
        
        pageIndex = pageIndex - 1
        return self.getViewController(withIndex: pageIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageIndex = (viewController as? OnboardingWelcomeContentController)?.dataSource.pageIndex ?? presenter.pagesCount - 1
        
        if pageIndex == presenter.pagesCount - 1 {
            return nil
        }
        
        pageIndex = pageIndex + 1
        return self.getViewController(withIndex: pageIndex)
    }
    
    fileprivate func getViewController(withIndex:Int) -> UIViewController? {
        if let contentViewController: OnboardingWelcomeContentController =  self.storyboard?.getViewController() {
            contentViewController.dataSource = presenter.dataSource[withIndex]
            contentViewController.pagesCount = presenter.pagesCount
            contentViewController.presentNextScreen { (index) in
                if let nextVc = self.getViewController(withIndex: index+1) {
                    self.setViewControllers([nextVc], direction: .forward, animated: true, completion: nil)
                }
            }
            return contentViewController
        }
        return nil
    }
}
