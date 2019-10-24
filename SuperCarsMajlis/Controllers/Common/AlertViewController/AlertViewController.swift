//
//  AlertViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 29/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    /*
     MARK: Properties
     */
    @IBOutlet weak var bgView           : UIView!
    @IBOutlet weak var btnA             : UIButton!
    @IBOutlet weak var btnB             : UIButton!
    @IBOutlet weak var lblSeprator      : UILabel!
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var lblMessage       : UILabel!
    
    private var alertCompletionBlock    : AlertCompletionBlock!
    internal typealias AlertCompletionBlock         = (_ index : Int?) -> Void
    
    static let sharedInstance           : AlertViewController = {
        let instance = Constants.commonStoryboard.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        return instance
    }()
    //end
    
    /*
     MARK: UIViewController Life Cycle
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setUpUI()
    }
    //end
    
    //MARK: - SetUp UI
    /**
     Set Up UI of Alery View
     */
    func setUpUI(){
      
        //Set View Layout
        self.bgView.layer.cornerRadius = 8

        //Backgroung Color
        self.bgView.backgroundColor = UIColor.gradient(from: UIColor(red:56.0/255.0, green:56.0/255.0 ,blue:67.0/255.0 , alpha:1.0), to: UIColor(red:39.0/255.0, green:39.0/255.0 ,blue:47.0/255.0 , alpha:1.0), withHeight: Int(self.bgView.frame.height))
    }

    class func openAlertView(title: String, message: String, buttons:[String], completionHandler: @escaping AlertCompletionBlock) {

        AlertViewController.sharedInstance.alertCompletionBlock = completionHandler

        AlertViewController.sharedInstance.openAlert(title: title, message: message, buttons: buttons, tapBlock: completionHandler)
    }
    
    class func openAlertView(title: String, message: String, buttons:[String]) {

        AlertViewController.sharedInstance.alertCompletionBlock = nil
        
        AlertViewController.sharedInstance.openAlert(title: title, message: message, buttons: buttons, tapBlock: nil)
    }

    
    func openAlert(title: String, message: String, buttons:[String], tapBlock:((Int) -> Void)?){
        
        guard var rootVC = Constants.kAppDelegate.window?.rootViewController else {
            return
        }
        
//        if let vc = rootVC.presentedViewController{
//            rootVC = vc
//        }

        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        rootVC.present(self, animated: false, completion: nil)
        
        self.lblTitle.text = title
        
        self.lblMessage.text = message
    
        
        if title.lowercased().contains("success"){
            self.lblSeprator.backgroundColor = UIColor(named: "customGreen")
        }else if title.lowercased().contains("error"){
            self.lblSeprator.backgroundColor = UIColor(named: "customRed")
        }else if title.lowercased().contains("warning"){
            self.lblSeprator.backgroundColor = UIColor.orange
        }else{
            self.lblSeprator.backgroundColor = UIColor.white
        }
        
        if buttons.count > 0{
            if buttons.count > 1{
                self.btnA.setTitle(buttons[0], for: .normal)
                self.btnB.setTitle(buttons[1], for: .normal)
                self.btnB.isHidden = false
            }else{
                self.btnA.setTitle(buttons[0], for: .normal)
                self.btnB.isHidden = true
            }
        }else{
            self.btnA.setTitle("OK", for: .normal)
            self.btnB.isHidden = true
        }
        
        self.viewDidAppear(true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnATapped(_ sender: Any) {
        if self.alertCompletionBlock != nil{
            self.alertCompletionBlock(0)
        }
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func btnBTapped(_ sender: Any) {
        if self.alertCompletionBlock != nil{
            self.alertCompletionBlock(1)
        }
        self.dismiss(animated: false, completion: nil)
    }

}
