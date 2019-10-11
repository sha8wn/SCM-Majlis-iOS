//
//  EventRegistrationViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 09/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class EventRegistrationViewController: UIViewController {

    /*
     MARK: - Properties
     */
    
    @IBOutlet weak var MOTopView      : UIView!
    @IBOutlet weak var MOBottomView   : UIView!
    @IBOutlet weak var MOLeftView     : UIView!
    @IBOutlet weak var MiddleView     : UIView!
    @IBOutlet weak var MGTopView      : UIView!
    @IBOutlet weak var MGBottomView   : UIView!
    @IBOutlet weak var MGRightView    : UIView!
    
    
    @IBOutlet weak var bgView               : UIView!
    @IBOutlet weak var memberGuestView      : UIView!
    @IBOutlet weak var memberOnlyView       : UIView!
    @IBOutlet weak var btnReserve           : UIButton!
    @IBOutlet weak var collectionView       : UICollectionView!
    @IBOutlet weak var lblStaticSelectCar   : UILabel!
    @IBOutlet weak var lblMemberGuest       : UILabel!
    @IBOutlet weak var lblRSVPMemberGuest   : UILabel!
    @IBOutlet weak var lblMemberOnly        : UILabel!
    @IBOutlet weak var lblRSVPMember        : UILabel!
    @IBOutlet weak var btnRSVPMemberGuest   : UIButton!
    @IBOutlet weak var btnRSVPMember        : UIButton!
    @IBOutlet weak var lblEventTitle        : UILabel!
    @IBOutlet weak var btnBack              : UIButton!
    var selectedIndex                       : Int!
    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    
    
    /*
     MARK: - Setup View
     */
    func setupView(){
        //Register CollectionView Cell
        self.collectionView.register(UINib(nibName: "CarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarCollectionViewCell")
        self.collectionView.register(UINib(nibName: "SelectedCarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SelectedCarCollectionViewCell")
        
        //Reserve My Spot Button
        self.btnReserve.isEnabled = false
        
        //SetUp RSVP Button
        self.setUpButton(button: self.btnRSVPMember)

        
    }
    //end
    
    func setUpButton(button: UIButton){
        if self.btnRSVPMember == button{
            //Selected
            self.lblMemberOnly.textColor = UIColor.white
            self.lblRSVPMember.textColor = UIColor.white
//            self.memberOnlyView.layer.borderWidth = 1
//            self.memberOnlyView.layer.borderColor = UIColor(named: "customRed")?.cgColor
            self.memberOnlyView.backgroundColor = UIColor.gradient(from: UIColor(red:56.0/255.0, green:56.0/255.0 ,blue:67.0/255.0 , alpha:1.0), to: UIColor(red:39.0/255.0, green:39.0/255.0 ,blue:47.0/255.0 , alpha:1.0), withHeight: Int(self.memberOnlyView.frame.height))
            
            //UnSelected
            self.lblMemberGuest.textColor = UIColor(named: "customWhite50Opacity")
            self.lblRSVPMemberGuest.textColor = UIColor(named: "customWhite50Opacity")
//            self.memberGuestView.layer.borderWidth = 1
//            self.memberGuestView.layer.borderColor = UIColor(named: "customWhite50Opacity")?.cgColor
            self.memberGuestView.backgroundColor = UIColor.clear
        }else{
            //Selected
            self.lblMemberGuest.textColor = UIColor.white
            self.lblRSVPMemberGuest.textColor = UIColor.white
//            self.memberGuestView.layer.borderWidth = 1
//            self.memberGuestView.layer.borderColor = UIColor(named: "customRed")?.cgColor
            self.memberGuestView.backgroundColor = UIColor.gradient(from: UIColor(red:56.0/255.0, green:56.0/255.0 ,blue:67.0/255.0 , alpha:1.0), to: UIColor(red:39.0/255.0, green:39.0/255.0 ,blue:47.0/255.0 , alpha:1.0), withHeight: Int(self.memberGuestView.frame.height))
            
            //UnSelected
            self.lblMemberOnly.textColor = UIColor(named: "customWhite50Opacity")
            self.lblRSVPMember.textColor = UIColor(named: "customWhite50Opacity")
//            self.memberOnlyView.layer.borderWidth = 1
//            self.memberOnlyView.layer.borderColor = UIColor(named: "customWhite50Opacity")?.cgColor
            self.memberOnlyView.backgroundColor = UIColor.clear
        }
        
        self.bgView.layer.borderWidth = 1
        self.bgView.layer.borderColor = UIColor.clear.cgColor

//        self.bgView.layer.borderColor = UIColor(named: "customRed")?.cgColor
        self.MiddleView.backgroundColor = UIColor(named: "customRed")
        
        if self.btnRSVPMember == button{
            //Selected
            self.MOLeftView.backgroundColor = UIColor(named: "customRed")
            self.MOTopView.backgroundColor = UIColor(named: "customRed")
            self.MOBottomView.backgroundColor = UIColor(named: "customRed")
            
            //UnSelected
            self.MGTopView.backgroundColor = UIColor(named: "customWhite50Opacity")
            self.MGBottomView.backgroundColor = UIColor(named: "customWhite50Opacity")
            self.MGRightView.backgroundColor = UIColor(named: "customWhite50Opacity")
        }else{
            //Selected
            self.MOLeftView.backgroundColor = UIColor(named: "customWhite50Opacity")
            self.MOTopView.backgroundColor = UIColor(named: "customWhite50Opacity")
            self.MOBottomView.backgroundColor = UIColor(named: "customWhite50Opacity")
            
            //UnSelected
            self.MGTopView.backgroundColor = UIColor(named: "customRed")
            self.MGBottomView.backgroundColor = UIColor(named: "customRed")
            self.MGRightView.backgroundColor = UIColor(named: "customRed")
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
    
    @IBAction func btnRSVPMemberTapped(_ sender: Any) {
        self.setUpButton(button: self.btnRSVPMember)
    }
    
    @IBAction func btnRSVPMemberGuestTapped(_ sender: Any) {
        self.setUpButton(button: self.btnRSVPMemberGuest)
    }
    
    @IBAction func btnReserve(_ sender: Any) {
    }
}

/*
 MARK: - UICollectionView Delegate and DataSources
 */
extension EventRegistrationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.selectedIndex != nil && self.selectedIndex ==  indexPath.item{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedCarCollectionViewCell", for: indexPath) as! SelectedCarCollectionViewCell
            cell.bgView.backgroundColor = UIColor.gradient(from: UIColor(red:190.0/255.0, green:40.0/255.0 ,blue:64.0/255.0 , alpha:1.0), to: UIColor(red:95.0/255.0, green:20.0/255.0 ,blue:32.0/255.0 , alpha:1.0), withHeight: 240)
            cell.lblCarName.text = "Lamborghini"
            cell.lblCarModel.text = "Aventador"
            cell.imgCar.image = UIImage(named: "ic_Demo")
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCollectionViewCell", for: indexPath) as! CarCollectionViewCell
            cell.bgView.backgroundColor = UIColor.gradient(from: UIColor(red:56.0/255.0, green:56.0/255.0 ,blue:67.0/255.0 , alpha:1.0), to: UIColor(red:39.0/255.0, green:39.0/255.0 ,blue:47.0/255.0 , alpha:1.0), withHeight: 200)
            cell.lblCarName.text = "Lamborghini"
            cell.lblCarModel.text = "Aventador"
            cell.imgCar.image = UIImage(named: "ic_Demo")
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.selectedIndex != nil{
            if self.selectedIndex == indexPath.item{
                return CGSize(width: 160, height: 300)
            }else{
                return CGSize(width: 140, height: 300)
            }
        }else{
            return CGSize(width: 140, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.item
        self.collectionView.reloadData()
    }
}