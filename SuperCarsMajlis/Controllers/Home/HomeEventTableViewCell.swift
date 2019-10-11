//
//  HomeEventTableViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 07/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

protocol MemberGoingDelegate {
    func memberGoingTapped()
}

class HomeEventTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView      : UICollectionView!
    @IBOutlet weak var collectionViewWidth : NSLayoutConstraint!
    @IBOutlet weak var imgLive             : UIImageView!
    @IBOutlet weak var lblLocation         : UILabel!
    @IBOutlet weak var lblNoOfGoing        : UILabel!
    @IBOutlet weak var lblEventTitle       : UILabel!
    @IBOutlet weak var lblDateAndTime      : UILabel!
    @IBOutlet weak var imgView             : UIImageView!
    @IBOutlet weak var lblSepratorDate     : UILabel!
    @IBOutlet weak var imgViewLocation     : UIImageView!
    @IBOutlet weak var imgViewPeople       : UIImageView!
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
    
}

/*
 MARK: - UICollectionView Delegate and DataSources
*/
extension HomeEventTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell
        
       
        if indexPath.item == 4{
            cell.lblTitle.isHidden = false
            cell.lblTitle.text = "5 going"
            cell.lblTitle.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            cell.bgView.layer.cornerRadius = 15
            cell.bgView.layer.borderWidth = 1
            cell.bgView.layer.borderColor = UIColor.white.cgColor
            cell.bgView.backgroundColor = UIColor(named: "customGreyColor")
        }else{
            cell.lblTitle.isHidden = true
            cell.bgView.layer.cornerRadius = cell.frame.width / 2
            cell.bgView.layer.borderWidth = 0
            cell.bgView.layer.borderColor = UIColor.clear.cgColor
            
            if indexPath.item == 1{
                cell.bgView.backgroundColor = UIColor.red
            }else if indexPath.item == 2{
                cell.bgView.backgroundColor = UIColor.yellow
            }else if indexPath.item == 3{
                cell.bgView.backgroundColor = UIColor.green
            }else{
                cell.bgView.backgroundColor = UIColor.brown
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
        if indexPath.item == 4{
            return CGSize(width: 80, height: 30)
        }else{
            return CGSize(width: 30, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.memeberDelegate.memberGoingTapped()
    }
}
