//
//  BecomeMemberViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 26/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class BecomeMemberViewController: UIViewController {
    
    /*
     MARK: - Properties
     */
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var txtView: UITextView!
    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributedString = NSMutableAttributedString(string: "Completing this from not guarantee an SCM membersip. You will be notified if your application is successful. Please read our privacy policy and terms & conditions to know more about our selection process")
        let linkRange1 = (attributedString.string as NSString).range(of: "terms & conditions")
        attributedString.addAttribute(NSAttributedString.Key.link, value: "Terms", range: linkRange1)
        let linkRange2 = (attributedString.string as NSString).range(of: "privacy policy")
        attributedString.addAttribute(NSAttributedString.Key.link, value: "Privacy", range: linkRange2)
        
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineColor.rawValue): UIColor.white,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineStyle.rawValue): NSUnderlineStyle.single.rawValue
        ]
        
        txtView.textContainerInset = .zero
        txtView.textContainer.lineFragmentPadding = 0
        txtView.linkTextAttributes = linkAttributes
        txtView.attributedText = attributedString
        txtView.font = UIFont(name: "Poppins-Regular", size: 18.0)
        txtView.textColor = UIColor.white.withAlphaComponent(0.6)
        txtView.textAlignment = .left
        txtView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: - WebView
    /**
     This function used to open webview screen
     */
    func openWebView(urlString: String? = ""){
        let viewController = Constants.commonStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        viewController.urlString = urlString ?? ""
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func btnRegisterTapped(_ sender: UIButton){
        let viewController = Constants.loginAndSignupStoryboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

/*
 MARK: - Extension SignUpVC of UITextViewDelegate
 */
extension BecomeMemberViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.openWebView(urlString: URL.absoluteString)
        return false
    }
}
//end
