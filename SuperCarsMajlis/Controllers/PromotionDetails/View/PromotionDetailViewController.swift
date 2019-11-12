//
//  PromotionDetailViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 04/11/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SDWebImage

class PromotionDetailViewController: UIViewController {

    @IBOutlet weak var lblTC: UILabel!
    @IBOutlet weak var lblPartnerLongDesc: UILabel!
    @IBOutlet weak var lblPartnerDesc: UILabel!
    @IBOutlet weak var lblPatnerTitle: UILabel!
    @IBOutlet weak var lblPartnerImgView: UIImageView!
    @IBOutlet weak var lblPromotionDesc: UILabel!
    @IBOutlet weak var lblPromotionTitle: UILabel!
    @IBOutlet weak var btnReedem: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    var dataModel: PromotionsList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView(){
        if self.dataModel != nil{
            
            self.lblPromotionTitle.text = self.dataModel.partner_name ?? ""
            self.lblPromotionDesc.text = self.dataModel.name ?? ""
            
            //Image
            self.lblPartnerImgView.sd_imageIndicator = SDWebImageActivityIndicator.white
            self.lblPartnerImgView.sd_setImage(with: URL(string: self.dataModel.partner_img ?? ""), completed: nil)
            
            self.lblPatnerTitle.text = self.dataModel.partner_location ?? ""
            self.lblPartnerDesc.text = self.dataModel.partner_phone ?? ""
            
            self.lblPartnerLongDesc.text  = self.dataModel.text ?? ""
    
            self.lblTC.text = self.dataModel.terms ?? ""
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnReedemTapped(_ sender: Any) {
        let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "RedeemViewController") as! RedeemViewController
        vc.promotionId = self.dataModel.id ?? 0
        self.present(vc, animated: true, completion: nil)
    }
    
}
