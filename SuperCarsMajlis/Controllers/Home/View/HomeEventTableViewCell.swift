//
//  HomeEventTableViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 07/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SDWebImage

protocol MemberGoingDelegate {
    func memberGoingTapped(model: HomeList)
}

class HomeEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView      : UICollectionView!
    @IBOutlet weak var collectionViewWidth : NSLayoutConstraint!
    @IBOutlet weak var imgLive             : UIImageView!
    @IBOutlet weak var viewAmountBG        : UIView!
    @IBOutlet weak var lblAmount           : UILabel!
    @IBOutlet weak var lblLocation         : UILabel!
    @IBOutlet weak var lblNoOfGoing        : UILabel!
    @IBOutlet weak var lblEventTitle       : UILabel!
    @IBOutlet weak var lblDateAndTime      : UILabel!
    @IBOutlet weak var imgView             : UIImageView!
    @IBOutlet weak var lblSepratorDate     : UILabel!
    @IBOutlet weak var imgViewLocation     : UIImageView!
    @IBOutlet weak var imgViewPeople       : UIImageView!
    var dataModel                          : HomeList!
    var memberGoingArray                   : [HomeUsers]        = []
    var memeberDelegate                    : MemberGoingDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        self.collectionView.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        
        //Collection View Width
        self.collectionViewWidth.constant = 160
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUpCell(model: HomeList){
        //Model
        self.dataModel = model
        
        //Event Name
        self.lblEventTitle.text = model.name ?? ""
        
        // Member Going
        if let userArray = model.users{
            if userArray.count > 4{
                self.memberGoingArray = Array(userArray.prefix(4))
            }else{
                self.memberGoingArray = userArray
            }
        }
        
        // Set Live Image
        if (model.status ?? "").lowercased() == "live"{
            self.imgLive.isHidden = false
        }else{
            self.imgLive.isHidden = true
        }
        
        //Amount
        if let fee = dataModel.fee{
            if fee != 0{
                self.lblAmount.text = "AED \(fee)"
                self.lblAmount.textColor = .black
                self.viewAmountBG.backgroundColor = .white
            }else{
                self.lblAmount.text = "Free"
                self.lblAmount.textColor = .white
                self.viewAmountBG.backgroundColor = UIColor.gradient(from: UIColor(red:93.0/255.0, green:194.0/255.0 ,blue:255.0/255.0 , alpha:1.0), to: UIColor(red:26.0/255.0, green:137.0/255.0 ,blue:255.0/255.0 , alpha:1.0), withHeight: Int(self.viewAmountBG.frame.height))
            }
        }else{
            self.lblAmount.text = "Free"
            self.lblAmount.textColor = .white
            self.viewAmountBG.backgroundColor = UIColor.gradient(from: UIColor(red:93.0/255.0, green:194.0/255.0 ,blue:255.0/255.0 , alpha:1.0), to: UIColor(red:26.0/255.0, green:137.0/255.0 ,blue:255.0/255.0 , alpha:1.0), withHeight: Int(self.viewAmountBG.frame.height))
        }
        
        //Date
        self.lblDateAndTime.text = String(format: "%@\n%@", model.date ?? "", model.start ?? "")
        
        //Location
        self.lblLocation.text = model.location ?? ""
        
        //Image
        DispatchQueue.main.async {
            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
            self.imgView.sd_setImage(with: URL(string: model.img ?? ""), placeholderImage: UIImage(named: ""), options: .handleCookies, progress: nil, completed: nil)
            
            self.collectionView.reloadData()
        }
        
        
        //Remaning Spot
        let totalSpot = model.limit_guests ?? 0
        var totalOccupiedSpot: Int = 0
        var vacentSpot: Int = 0
        
        if totalSpot != 0{
            self.imgViewPeople.isHidden = false
            if let userArray = model.users{
                if userArray.count > 0{
                    for model in userArray{
                        totalOccupiedSpot = totalOccupiedSpot + (model.guests ?? 0)
                    }
                }
            }
            print("totalOccupiedSpot, ", totalOccupiedSpot)
            vacentSpot = totalSpot - totalOccupiedSpot
            
            if vacentSpot > 0{
                self.lblNoOfGoing.text = "\(vacentSpot) spots remaining"
            }else{
                self.lblNoOfGoing.text = "Fully Booked"
            }
            
        }else{
            self.imgViewPeople.isHidden = true
            self.lblNoOfGoing.text = ""
        }
    }
}

/*
 MARK: - UICollectionView Delegate and DataSources
 */
extension HomeEventTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.memberGoingArray.count > 0{
            return self.memberGoingArray.count + 1
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell
        
        
        if indexPath.item == self.memberGoingArray.count{
            cell.lblTitle.isHidden = false
            if self.dataModel != nil{
                cell.lblTitle.text = String(format: "%@ going", String(self.dataModel.users!.count))
            }
            cell.lblTitle.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            cell.bgView.layer.cornerRadius = 15
            cell.bgView.layer.borderWidth = 1
            cell.bgView.layer.borderColor = UIColor.white.cgColor
            cell.bgView.backgroundColor = UIColor(named: "customGreyColor")
            cell.imgView.image = UIImage(named: "")
        }else{
            let model = self.memberGoingArray[indexPath.item]
            cell.lblTitle.isHidden = true
            cell.bgView.layer.cornerRadius = cell.frame.width / 2
            cell.bgView.layer.borderWidth = 0
            cell.bgView.layer.borderColor = UIColor.clear.cgColor
            cell.bgView.backgroundColor = UIColor.clear
            DispatchQueue.main.async {
                //Image
                cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
                cell.imgView.sd_setImage(with: URL(string: model.img ?? ""), placeholderImage: UIImage(named: "ic_Default_Image"), options: .highPriority, progress: nil, completed: nil)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.memberGoingArray.count > 0{
            if indexPath.item == self.memberGoingArray.count{
                return CGSize(width: 80, height: 30)
            }else{
                return CGSize(width: 30, height: 30)
            }
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.dataModel != nil{
            self.memeberDelegate.memberGoingTapped(model: self.dataModel)
        }
    }
}
