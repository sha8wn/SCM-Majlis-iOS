//
//  RedeemViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 05/11/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class RedeemViewController: UIViewController {

    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var otpView: VPMOTPView!
    var enteredOtp: String = ""
    var promotionId: Int!
    var isSuccessfullyRedeem: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initializeOTPView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initializeOTPView(){
        self.otpView.otpFieldsCount = 4
        self.otpView.otpFieldDefaultBackgroundColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        self.otpView.otpFieldEnteredBackgroundColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        self.otpView.otpFieldDisplayType = .rectangle
        self.otpView.otpFieldInputType = .numeric
        self.otpView.cursorColor = UIColor.white
        self.otpView.otpFieldSeparatorSpace = 10
        self.otpView.otpFieldSize = 60
        self.otpView.otpFieldBorderWidth = 1
        self.otpView.otpFieldDefaultBorderColor = UIColor.white.withAlphaComponent(0.2)
        self.otpView.otpFieldEnteredBorderColor = UIColor.white.withAlphaComponent(0.2)
        self.otpView.otpFieldErrorBorderColor = UIColor.white.withAlphaComponent(0.2)
        self.otpView.delegate = self
        self.otpView.shouldAllowIntermediateEditing = false
        
        // Create the UI
        self.otpView.initializeUI()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnCrossTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension RedeemViewController: VPMOTPViewDelegate {
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        if hasEntered{
            self.callRedeemAPI(code: Int(enteredOtp) ?? 0, promotionId: self.promotionId ?? 0)
        }
        return hasEntered
    }
    
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otpString: String) {
        enteredOtp = otpString
        print("OTPString: \(otpString)")
    }
}
