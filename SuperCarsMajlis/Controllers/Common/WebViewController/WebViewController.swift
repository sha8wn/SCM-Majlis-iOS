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
        if urlString == "Terms" || urlString == "Privacy"{
            self.callGetPages(endPoint: urlString)
        }else{
            if FunctionConstants.getInstance().isValidUrl(urlString: self.urlString){
               let url = URL(string: urlString)
               self.webView.load(URLRequest(url: url!))
           }else{
                AlertViewController.openAlertView(title: "Error", message: "Incorrect URL!", buttons: ["OK"]) { (index) in
                    self.navigationController?.popViewController(animated: true)
                }
           }
        }
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

/*
 MARK: - WebViewController- WKNavigationDelegate
 */
extension WebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        FunctionConstants.getInstance().hideLoader(view: self)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        FunctionConstants.getInstance().showLoader(message: "LOADING", view: self)
    }
}

/*
MARK: - WebViewController- Webservice
*/
extension WebViewController{
    func callGetPages(endPoint: String){
        FunctionConstants.getInstance().showLoader(message: "LOADING", view: self)
        let urlPath = kBaseURL + kGetPagesAPI
        Network.shared.request(urlPath: urlPath, methods: .get, authType: .basic) {
            (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                if let responseDict = response!.result.value as? NSDictionary{
                    if let pagesDict = responseDict.value(forKey: "pages") as? NSDictionary{
                        if let listArray = pagesDict.value(forKey: "list") as? NSArray{
                            if listArray.count > 0{
                                for i in 0...listArray.count - 1{
                                    let dict = listArray[i] as! NSDictionary
                                    let title = dict.value(forKey: "title") as! String
                                    if title.lowercased() == endPoint.lowercased(){
                                        if let text = dict.value(forKey: "text") as? String{
                                            self.webView.loadHTMLString(text, baseURL: nil)
                                        }else{
                                            
                                        }
                                    }
                                }
                            }else{
                                AlertViewController.openAlertView(title: "Error", message: "Incorrect URL!", buttons: ["OK"]) { (index) in
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                        }else{
                            AlertViewController.openAlertView(title: "Error", message: "Incorrect URL!", buttons: ["OK"]) { (index) in
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }else{
                        AlertViewController.openAlertView(title: "Error", message: "Incorrect URL!", buttons: ["OK"]) { (index) in
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }else{
                    AlertViewController.openAlertView(title: "Error", message: "Incorrect URL!", buttons: ["OK"]) { (index) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: "Incorrect URL!", buttons: ["OK"]) { (index) in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
