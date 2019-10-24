//
//  PastEventTableViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 26/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SDWebImage

/*
 MARK: - Delegate PastEvent Selected
 */
protocol PastEventDelegate {
    func eventSelected(index: Int, imageArray: [PastEventImages])
}

class PastEventTableViewCell: UITableViewCell {

    /*
     MARK: - Properties
    */
    @IBOutlet var collectionView: UICollectionView!
    var delegate                : PastEventDelegate!
    var index                   : Int!
    var eventData               : PastEventList!
    var imageArray              : [PastEventImages]     = []
    //end
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register(UINib(nibName: "PaseEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PaseEventCollectionViewCell")
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(model: PastEventList){
        DispatchQueue.main.async {
            self.eventData = model
            if self.eventData != nil{
                if let array = self.eventData.imgs{
                    self.imageArray = array
                }else{
                    self.imageArray = []
                }
            }else{
                self.imageArray = []
            }
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
        }
    }
}

/*
 MARK: - UICollectionView Delegate and DataSources
*/
extension PastEventTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.imageArray.count > 0{
            return self.imageArray.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaseEventCollectionViewCell", for: indexPath) as! PaseEventCollectionViewCell
        
        //Data
        cell.lblEventTitle.text = self.eventData.name ?? ""
        cell.lblDateAndTime.text = self.eventData.date ?? ""
        cell.lblLocation.text = self.eventData.location ?? ""
        cell.lblNoOfGoing.text = String(format: "%@ participants", self.eventData.participants ?? "0")
        
        //Images
        var url: String = ""
        if let imageURL = self.imageArray[indexPath.item].img{
            url = imageURL
        }else{
            url = ""
        }
        cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
        if url != ""{
            cell.imgView.sd_setImage(with: URL(string: url), completed: nil)
        }else{
            cell.imgView.image = UIImage(named: "")
        }
        
        if indexPath.item == 0{
            cell.lblLocation.isHidden = false
            cell.lblNoOfGoing.isHidden = false
            cell.lblEventTitle.isHidden = false
            cell.lblDateAndTime.isHidden = false
            cell.imgView.isHidden = false
            cell.lblSepratorDate.isHidden = false
            cell.imgViewLocation.isHidden = false
            cell.imgViewPeople.isHidden = false
        }else{
            cell.lblLocation.isHidden = true
            cell.lblNoOfGoing.isHidden = true
            cell.lblEventTitle.isHidden = true
            cell.lblDateAndTime.isHidden = true
            cell.imgView.isHidden = false
            cell.lblSepratorDate.isHidden = true
            cell.imgViewLocation.isHidden = true
            cell.imgViewPeople.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.eventSelected(index: indexPath.item, imageArray: self.imageArray)
    }
}
