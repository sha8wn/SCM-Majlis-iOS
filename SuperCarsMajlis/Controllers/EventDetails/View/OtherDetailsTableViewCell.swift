//
//  OtherDetailsTableViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 10/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SDWebImage

class OtherDetailsTableViewCell: UITableViewCell {

    /*
     MARK: - Properties
     */
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    var partnerArray: [HomePartners] = []
    var brandArray: [HomeBrands] = []
    var type: String = ""
    
    //end
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register(UINib(nibName: "EventOtherDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventOtherDetailsCollectionViewCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(type: String, array: [Any]){
        self.type = type
        
        if let _ = array as? [HomeBrands]{
            self.brandArray = array as! [HomeBrands]
        }else {
            self.brandArray = []
        }
        
        if let _ = array as? [HomePartners]{
            self.partnerArray = array as! [HomePartners]
        }else {
            self.partnerArray = []
        }
        
        self.collectionView.reloadData()
    }
    
}

/*
 MARK: - UICollectionView Delegate and DataSources
*/
extension OtherDetailsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == "brand"{
            if self.brandArray.count > 0{
                return self.brandArray.count
            }else{
                return 0
            }
        }else if type == "partner"{
            if self.partnerArray.count > 0{
                return self.partnerArray.count
            }else{
                return 0
            }
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventOtherDetailsCollectionViewCell", for: indexPath) as! EventOtherDetailsCollectionViewCell
        if type == "brand"{
            let model = self.brandArray[indexPath.item]
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
            cell.imgView.sd_setImage(with: URL(string: model.img ?? ""), placeholderImage: UIImage(named: ""), options: .handleCookies, progress: nil, completed: nil)
            
            cell.lblTitle.text = model.name ?? ""
        }else if type == "partner"{
            let model = self.partnerArray[indexPath.item]
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
            cell.imgView.sd_setImage(with: URL(string: model.img ?? ""), placeholderImage: UIImage(named: ""), options: .handleCookies, progress: nil, completed: nil)
            
            cell.lblTitle.text = model.name ?? ""
        }else{
            cell.imgView.image = UIImage(named: "")
            cell.lblTitle.text = "-"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 120)
    }
}
