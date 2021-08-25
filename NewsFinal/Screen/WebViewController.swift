//
//  WebViewController.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let webView = WKWebView()
    var URL: URL?
    
    //MARK: - LifeCycle
    override func loadView() {
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL else {return}
        
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: url))
        }
    }
}
