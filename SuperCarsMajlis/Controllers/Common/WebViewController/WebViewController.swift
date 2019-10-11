//
//  WebViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 27/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController {

    /*
     MARK: Properties
     */
    @IBOutlet weak var webView          : WKWebView!
    @IBOutlet weak var btn_back         : UIButton!
    var urlString                       : String        = ""
    //end
    
    /*
     MARK: UIViewController Life Cycle
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.navigationDelegate = self
        let url = URL(string: urlString)
        self.webView.load(URLRequest(url: url!))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btn_Back_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        FunctionConstants.getInstance().hideLoader(view: self)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        FunctionConstants.getInstance().showLoader(message: "LOADING", view: self)
    }
}
