//
//  WebViewController.swift
//  AouthModule
//
//  Created by Nitin Chadha on 07/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView: WKWebView!
    @IBOutlet weak var customView: UIView!
    
    var urlString: String?
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addWKWebView()
        if let urlString = urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        ActivityIndicator.showNative(on: self.view)
        self.title = titleString
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    private func addWKWebView() {
        webView = WKWebView(frame: customView.frame)
        webView.translatesAutoresizingMaskIntoConstraints=false
        self.customView.addSubview(webView)
        webView.addTopConstraint(with: 0.0, toView: customView)
        webView.addBottomConstraint(with: 0.0, toView: customView)
        webView.addLeadingConstraint(with: 0.0, toView: customView)
        webView.addTrailingConstraint(with: 0.0, toView: customView)
        webView.navigationDelegate = self
        webView.uiDelegate = self
    }
    
}

extension WebViewController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityIndicator.hideNative()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ActivityIndicator.hideNative()
    }
    
}
