//
//  EventDetailsViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 07/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    /*
     MARK: - Properties
     */
    @IBOutlet var btnBack                  : UIButton!
    @IBOutlet var btnReserve               : UIButton!
    @IBOutlet var tableView                : UITableView!
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
    var dataModel                          : HomeList!
    //end
    
    /*
     MARK: - UIViewController Life Cycle
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    //end
    
    /*
     MARK: - Setup View
     */
    func setupView(){
        //Register TableView Cell
        self.tableView.register(UINib(nibName: "EventDescTableViewCell", bundle: nil), forCellReuseIdentifier: "EventDescTableViewCell")
        self.tableView.register(UINib(nibName: "EventCheckPointsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventCheckPointsTableViewCell")
        self.tableView.register(UINib(nibName: "OtherDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherDetailsTableViewCell")
        
        //Register CollectionView Cell
        self.collectionView.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        
        //Setup Collection View
        self.collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        self.collectionViewWidth.constant = 160
        
        //Data
        if self.dataModel != nil{
            
        }else{
            
        }
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
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnReserveTapped(_ sender: Any) {
        let vc = Constants.eventStoryboard.instantiateViewController(withIdentifier: "EventRegistrationViewController") as! EventRegistrationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


/*
 MARK: - UICollectionView Delegate and DataSources
 */
extension EventDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
        let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "MemberGoingListViewController") as! MemberGoingListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


/*
 MARK: - EventDetailsViewController- UITableViewDelegate and UITableViewDataSource
 */
extension EventDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3{
            return 100
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventDescTableViewCell", for: indexPath) as! EventDescTableViewCell
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCheckPointsTableViewCell", for: indexPath) as! EventCheckPointsTableViewCell
            if indexPath.row == 0{
                cell.lblTitle.text = "Checkpoints " + "(" + "2" + ")"
                cell.checkInView.isHidden = true
            }else{
                cell.lblTitle.text = ""
                cell.checkInView.isHidden = false
            }
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherDetailsTableViewCell", for: indexPath) as! OtherDetailsTableViewCell
            cell.lblTitle.text = "Brands in the events"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherDetailsTableViewCell", for: indexPath) as! OtherDetailsTableViewCell
            cell.lblTitle.text = "Partners"
            return cell
        }
    }

}

