//
//  PastEventTableViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 26/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

protocol PastEventDelegate {
    func eventSelected(index: Int)
}

class PastEventTableViewCell: UITableViewCell {

    /*
     MARK: - Properties
    */
    @IBOutlet var collectionView: UICollectionView!
    var delegate: PastEventDelegate!
    var index: Int!
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
    
}

/*
 MARK: - UICollectionView Delegate and DataSources
*/
extension PastEventTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaseEventCollectionViewCell", for: indexPath) as! PaseEventCollectionViewCell
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
        self.delegate.eventSelected(index: indexPath.item)
    }
}
