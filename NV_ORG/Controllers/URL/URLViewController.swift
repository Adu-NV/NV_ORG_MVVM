//
//  URLViewController.swift
//  NV_ORG
//
//  Created by Netventure on 06/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import WebKit

class URLViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    var urlString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
load()

    }
    
    func load(){
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        if #available(iOS 13.0, *) {
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }else{
            self.dismiss(animated: false, completion: nil)
        }
    }
}
