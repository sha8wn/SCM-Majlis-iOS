//
//  FeedbackViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 10/12/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var txtSubject           : UITextField!
    @IBOutlet weak var txtMessage           : UITextView!
    @IBOutlet weak var btnSubmit            : UIButton!
    @IBOutlet weak var btnBack              : UIButton!
    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        //Firebase Analytics
        FirebaseAnalyticsManager.shared.logEvent(eventName: FirebaseEvent.FeedbackActivity.rawValue)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Set Up View
    func setup(){
        self.txtMessage.textContainerInset = UIEdgeInsets.zero
        self.txtMessage.textContainer.lineFragmentPadding = 0
        
        self.txtMessage.text = "Enter message here"
        self.txtMessage.delegate = self
        self.txtMessage.textColor = UIColor(named: "customWhite50Opacity")
        
        self.txtSubject.attributedPlaceholder = NSAttributedString(string: "Enter Subject here", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "customWhite50Opacity")!])

    }
    //end
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnSubmitFeedbackTapped(_ sender: Any) {
        self.view.endEditing(true)
        if self.txtSubject.text != ""{
            if self.txtMessage.text != nil && self.txtMessage.text != "Enter message here"{
                self.callFeedbackAPI(subject: self.txtSubject.text ?? "", message: self.txtMessage.text)
            }else{
                AlertViewController.openAlertView(title: "Error", message: "Please enter message.", buttons: ["OK"])
            }
        }else{
            AlertViewController.openAlertView(title: "Error", message: "Please enter subject.", buttons: ["OK"])
        }
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: UITextView Delegate
extension FeedbackViewController: UITextViewDelegate{
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.text == "Enter message here" {
//            textView.text = nil
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "Enter message here"
//        }
//    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(named: "customWhite50Opacity") {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter message here"
            textView.textColor = UIColor(named: "customWhite50Opacity")
        }
    }
}
