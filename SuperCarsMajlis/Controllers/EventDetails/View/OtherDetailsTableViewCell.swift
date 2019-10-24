//
//  OtherDetailsTableViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 10/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class OtherDetailsTableViewCell: UITableViewCell {

    /*
     MARK: - Properties
     */
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
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
    
}

/*
 MARK: - UICollectionView Delegate and DataSources
*/
extension OtherDetailsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventOtherDetailsCollectionViewCell", for: indexPath) as! EventOtherDetailsCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 120)
    }
}
