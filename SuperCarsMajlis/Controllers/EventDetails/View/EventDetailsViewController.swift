//
//  EventDetailsViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 07/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation


class EventDetailsViewController: UIViewController {
    
    /*
     MARK: - Properties
     */
    @IBOutlet var btnBack                  : UIButton!
    @IBOutlet var btnReserve               : UIButton!
    @IBOutlet var tableView                : UITableView!
    @IBOutlet weak var viewAmountBG        : UIView!
    @IBOutlet weak var lblAmount           : UILabel!
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
    var memberGoingArray                   : [HomeUsers]        = []
    var checkPointsArray                   : [CheckpointsList]  = []
    var brandArray                         : [HomeBrands]       = []
    var partnerArray                       : [HomePartners]     = []
    var eventId                            : Int                = 0
    let locationManager                                         = CLLocationManager()
    var latitude                           : Double             = 0
    var longitude                          : Double             = 0
    var selectedCheckPoint                 : Int!
    //end
    
    /*
     MARK: - UIViewController Life Cycle
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.callGetEventDetailAPI(event_Id: self.eventId)
        self.setupView()
        
        //Firebase Analytics
        FirebaseAnalyticsManager.shared.logEvent(eventName: FirebaseEvent.EventDetailActivity.rawValue)
    }
    //end
    
    func determineMyCurrentLocation() {
        
        // 1
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        // 1
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            break
        // 2
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
        
        // 4
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    
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
        
        self.btnReserve.isHidden = true
        
    }
    //end
    
    func setUpViewWithData(){
        //Data
        if self.dataModel != nil{
            //Event Name
            self.lblEventTitle.text = dataModel.name ?? ""
            
            // Member Going
            if let userArray = dataModel.users{
                if userArray.count > 4{
                    self.memberGoingArray = Array(userArray.prefix(4))
                }else{
                    self.memberGoingArray = userArray
                }
            }
            self.collectionView.reloadData()
            
            // Set Live Image
            if (dataModel.status ?? "").lowercased() == "live"{
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
            let eventDate = (dataModel.date ?? "").toDate(withFormat: "yyyy-MM-dd")
            let strEventDate = convertDateFormater(date: eventDate ?? Date(), format: "dd MMMM YY")
            self.lblDateAndTime.text = String(format: "%@\n%@ - %@", strEventDate, dataModel.start ?? "", dataModel.end ?? "")
//
//            self.lblDateAndTime.text = String(format: "%@\n%@", dataModel.date ?? "", dataModel.start ?? "")
            
            //Location
            self.lblLocation.text = dataModel.location ?? ""
            
            //Image
            DispatchQueue.main.async {
                self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
                self.imgView.sd_setImage(with: URL(string: self.dataModel.img ?? ""), placeholderImage: UIImage(named: ""), options: .handleCookies, progress: nil, completed: nil)
            }
            
            //Brands
            if let brand = self.dataModel.brands{
                if brand.count > 0{
                    self.brandArray = brand
                }else{
                    self.brandArray = []
                }
            }else{
                self.brandArray = []
            }
            
            //Patners
            if let partners = self.dataModel.partners{
                if partners.count > 0{
                    self.partnerArray = partners
                }else{
                    self.partnerArray = []
                }
            }else{
                self.partnerArray = []
            }
            
            var vacentSpot: Int = 0
            let carLimit = dataModel.limit_cars ?? 0
            if  carLimit != 0{
                let totalGoingUser = dataModel.users?.count ?? 0
                vacentSpot = carLimit - totalGoingUser
                if totalGoingUser < carLimit{
                    self.lblNoOfGoing.text = "\(vacentSpot) spots remaining"
                }else if totalGoingUser >= carLimit{
                    self.lblNoOfGoing.text = "Fully Booked"
                }
            }else{
                self.imgViewPeople.isHidden = true
                self.lblNoOfGoing.text = ""
                vacentSpot = 1
            }
            
//            //Remaning Spot
//            let totalSpot = dataModel.limit_guests ?? 0
//            var totalOccupiedSpot: Int = 0
//            var vacentSpot: Int = 0
//
//            if totalSpot != 0{
//                self.imgViewPeople.isHidden = false
//                if let userArray = dataModel.users{
//                    if userArray.count > 0{
//                        for model in userArray{
//                            totalOccupiedSpot = totalOccupiedSpot + (model.guests ?? 0)
//                        }
//                    }
//                }
//                print("totalOccupiedSpot, ", totalOccupiedSpot)
//                vacentSpot = totalSpot - totalOccupiedSpot
//                if vacentSpot > 0{
//                    self.lblNoOfGoing.text = "\(vacentSpot) spots remaining"
//                }else{
//                    self.lblNoOfGoing.text = "Fully Booked"
//                }
//            }else{
//                self.imgViewPeople.isHidden = true
//                self.lblNoOfGoing.text = ""
//                vacentSpot = 1
//            }
            
            
            //Reserved
            if let reserved = self.dataModel.reservation{
                if reserved > 0{
                    if (dataModel.status ?? "").lowercased() == "live"{
                        self.btnReserve.isHidden = true
                        self.btnReserve.isEnabled = true
                    }else{
                        self.btnReserve.isHidden = false
                        self.btnReserve.isEnabled = true
                        self.btnReserve.setTitle("Cancel Reservation", for: .normal)
                        self.btnReserve.setBackgroundImage(UIImage(named: ""), for: .normal)
                        self.btnReserve.backgroundColor = UIColor(red: 166/255, green: 166/255, blue: 170/255, alpha: 1.0)
                    }
                }else{
                    if vacentSpot > 0{
                        self.btnReserve.isHidden = false
                        self.btnReserve.isEnabled = true
                        self.btnReserve.setTitle("Reserve my spot", for: .normal)
                        self.btnReserve.setBackgroundImage(UIImage(named: "ic_Button_BG_Red"), for: .normal)
                    }else{
                        self.btnReserve.isHidden = false
                        self.btnReserve.isEnabled = false
                        self.btnReserve.setTitle("Fully Booked", for: .normal)
                        self.btnReserve.setBackgroundImage(UIImage(named: ""), for: .normal)
                        self.btnReserve.backgroundColor = UIColor(red: 166/255, green: 166/255, blue: 170/255, alpha: 1.0)
                    }
                }
            }else{
                if vacentSpot > 0{
                    self.btnReserve.isEnabled = true
                    self.btnReserve.isHidden = false
                    self.btnReserve.setTitle("Reserve my spot", for: .normal)
                    self.btnReserve.setBackgroundImage(UIImage(named: "ic_Button_BG_Red"), for: .normal)
                }else{
                    self.btnReserve.isEnabled = true
                    self.btnReserve.isHidden = true
                }
            }
            
        }else{
            self.lblEventTitle.text = "-"
            self.imgLive.isHidden = true
            self.lblAmount.text = "-"
            self.lblNoOfGoing.text = "-"
            self.lblDateAndTime.text = "-"
            self.lblLocation.text = "-"
            
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
    
    @IBAction func btnReserveTapped(_ sender: Any) {
        if self.dataModel != nil{
            if self.dataModel.reservation ?? 0 > 0{
                //Call Unreserve API
                self.callUnreserveAPI(event_Id: self.dataModel.id ?? 0)
            }else{
                let vc = Constants.eventStoryboard.instantiateViewController(withIdentifier: "EventRegistrationViewController") as! EventRegistrationViewController
                vc.eventId = self.dataModel.id ?? 0
                vc.eventName = self.dataModel.name ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
        }
    }
}


/*
 MARK: - UICollectionView Delegate and DataSources
 */
extension EventDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
            cell.bgView.backgroundColor = .clear
            
            //Image
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
            cell.imgView.sd_setImage(with: URL(string: model.img ?? ""), placeholderImage: UIImage(named: "ic_Default_Image"), options: .highPriority, progress: nil, completed: nil)
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
        
        let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "MemberGoingListViewController") as! MemberGoingListViewController
        vc.dataModel = self.dataModel
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
            return self.checkPointsArray.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UITableView.automaticDimension
        }else if indexPath.section == 1{
            if self.checkPointsArray.count > 0{
                return UITableView.automaticDimension
            }else{
                return 0
            }
        }else if indexPath.section == 2{
            if self.brandArray.count > 0{
                return UITableView.automaticDimension
            }else{
                return 0
            }
        }else{
            if self.partnerArray.count > 0{
                return UITableView.automaticDimension
            }else{
                return 0
            }
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
            if self.dataModel != nil{
                cell.lblDesc.text = self.dataModel.text ?? "-"
            }else{
                cell.lblDesc.text = "-"
            }
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCheckPointsTableViewCell", for: indexPath) as! EventCheckPointsTableViewCell
            let checkPointModel = self.checkPointsArray[indexPath.row]
            
            if self.dataModel != nil{
                if self.dataModel.reservation ?? 0 > 0 && (self.dataModel.status ?? "").lowercased() == "live"{
                    cell.checkInView.isHidden = false
                }else{
                    cell.checkInView.isHidden = true
                }
            }
            
            if indexPath.row == 0{
                cell.lblTitle.text = "Checkpoints " + "(" + "\(self.checkPointsArray.count)" + ")"
            }else{
                cell.lblTitle.text = ""
            }
            
            //Title
            cell.lblLocation.text = checkPointModel.name ?? ""
            
            //Time
            var strHours: String = "00"
            var strMins: String = "00"
            if let hours = checkPointModel.hours{
                if hours.count > 1{
                    strHours = hours
                }else{
                    strHours = "0\(hours)"
                }
            }else{
                strHours = "00"
            }
            
            if let mins = checkPointModel.minutes{
                if mins.count > 1{
                    strMins = mins
                }else{
                    strMins = "0\(mins)"
                }
            }else{
                strMins = "00"
            }
            
            
            cell.lblTime.text = strHours + ":" + strMins
            
            //Checkin
            if checkPointModel.checked ?? 0 > 0{
                cell.btnCheckIn.setImage(UIImage(named: "ic_Checked-In"), for: .normal)
            }else{
                cell.btnCheckIn.setImage(UIImage(named: "ic_Check-In"), for: .normal)
            }
            
            cell.btnCheckIn.tag = indexPath.row
            cell.btnDirection.tag = indexPath.row
            cell.btnCheckIn.addTarget(self, action: #selector(btnCheckinTapped(sender:)), for: .touchUpInside)
            cell.btnDirection.addTarget(self, action: #selector(btnDirectionTapped(sender:)), for: .touchUpInside)
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherDetailsTableViewCell", for: indexPath) as! OtherDetailsTableViewCell
            cell.lblTitle.text = "Brands at the events"
            cell.setUpCell(type: "brand", array: self.brandArray)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherDetailsTableViewCell", for: indexPath) as! OtherDetailsTableViewCell
            cell.lblTitle.text = "Partners"
            cell.setUpCell(type: "partner", array: self.partnerArray)
            return cell
        }
    }
    
    @objc func btnDirectionTapped(sender: UIButton){
        let model = self.checkPointsArray[sender.tag]
        self.handleGoogleMap(lat: model.lat ?? "0", long: model.lng ?? "0")
    }
    
    @objc func btnCheckinTapped(sender: UIButton){
        self.determineMyCurrentLocation()
        if sender.image(for: .normal) == UIImage(named: "ic_Check-In"){
            self.selectedCheckPoint = sender.tag
        }else{
            self.selectedCheckPoint = nil
        }
    }
    
    func handleGoogleMap(lat: String, long: String){
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            UIApplication.shared.open(URL(string: "comgooglemaps://?center=\(lat),\(long)&zoom=14&views=traffic&q=loc:\(lat),\(long)")!, options: [:], completionHandler: nil)
        } else {
            print("Can't use comgooglemaps://")
            UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(lat),\(long)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
        }
    }
}


extension EventDetailsViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        self.latitude = userLocation.coordinate.latitude
        self.longitude = userLocation.coordinate.longitude
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        if self.selectedCheckPoint != nil{
            let model = self.checkPointsArray[self.selectedCheckPoint]
            self.callUpdateCheckPointAPI(checkPoint_Id: model.id ?? 0, lat: "\(self.latitude)", long: "\(self.longitude)")
            self.selectedCheckPoint = nil
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
