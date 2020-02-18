//
//  ManagerSuperCarsViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 09/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class ManagerSuperCarsViewController: UIViewController {
    
    /*
     MARK: - Properties
     */
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet var btnBack             : UIButton!
    @IBOutlet var btnSave             : UIButton!
    @IBOutlet var tableView           : UITableView!
    var dispatchGroup                                      = DispatchGroup()
    var dataArray                     : [SupercarsModel]   = [SupercarsModel()]
    //end
    
    /*
     MARK: - UIViewController Life Cycle
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.callGetSuperCarsListAPI()
        
        //Firebase Analytics
        FirebaseAnalyticsManager.shared.logEvent(eventName: FirebaseEvent.ManageSuperCarsActivity.rawValue)
        // Do any additional setup after loading the view.
    }
    //end
    
    /*
     MARK: - Setup View
     */
    func setupView(){
        self.tableView.register(UINib(nibName: "SupercarsFooterTableViewCell", bundle: nil), forCellReuseIdentifier: "SupercarsFooterTableViewCell")
        self.tableView.register(UINib(nibName: "SupercarsTableViewCell", bundle: nil), forCellReuseIdentifier: "SupercarsTableViewCell")
    }
    //end
    
    //MARK: - Validate Form
    private func getValidate(model: SupercarsModel) -> (Bool, String){
        var error : (Bool, String) = (false, "")
        if model.brand_Id == nil || model.brand_Id == 0 {
            error = (false, "Please select Brand")
        }
        else if model.model_Id == nil || model.model_Id == 0 {
            error = (false, "Please select Model")
        }
        else if model.color_Id == nil || model.color_Id == 0{
            error = (false, "Please Select Color")
        }
        else{
            error = (true, "")
        }
        return error
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
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        for model in self.dataArray{
            let (isValidate, errorMessage) = self.getValidate(model: model)
            if isValidate{
//                var error: Bool = false
//                if model.carRegistraionFrontImage == nil && model.carRegistraionBackImage == nil || model.carRegistraionFrontImageURL == nil && model.carRegistraionBackImageURL == nil{
//                }else{
//                    if model.carRegistraionFrontImage != nil && model.carRegistraionBackImage != nil || model.carRegistraionFrontImageURL != nil && model.carRegistraionBackImageURL != nil{
//                        error = false
//                    }else{
//                        error = true
//                    }
//                }
//
//                if error {
//                    AlertViewController.openAlertView(title: "Error", message: "Please Add Car Registration Document from both Side (Front and Back)", buttons: ["OK"])
//                    return
//                }else{
                    var carImageArray: [String] = []
                    //Car Image
                    if let carImage = model.carImage{
                        let carImageData: Data =  carImage.jpegData(compressionQuality: 0.25)!
                        carImageArray = [carImageData.base64EncodedString()]
                    }
                    var docsImageArray: [String] = []
                    //Docs Image
                    if let frontImage = model.carRegistraionFrontImage{
                        let frontImageData: Data =  frontImage.jpegData(compressionQuality: 0.25)!
                        docsImageArray.append(frontImageData.base64EncodedString())
                    }
                    
                    if let backImage = model.carRegistraionBackImage{
                        let backImageData: Data =  backImage.jpegData(compressionQuality: 0.25)!
                        docsImageArray.append(backImageData.base64EncodedString())
                    }
                    
                    if model.car_Id != nil{
                        self.callUpdateSuperCarsAPI(car_Id: model.car_Id!,
                                                    brand_Id: Int(model.brand_Id!) ,
                                                    model_Id: Int(model.model_Id!) ,
                                                    color_Id: Int(model.color_Id!) ,
                                                    imageArray: carImageArray,
                                                    docsArray: docsImageArray,
                                                    deletedImageArray: model.deleted_Car_Array ?? [],
                                                    deletedDocArray: model.deleted_Doc_Array ?? [])
                    }else{
                        self.callAddSuperCarsAPI(brand_Id: Int(model.brand_Id!) ,
                                                 model_Id: Int(model.model_Id!) ,
                                                 color_Id: Int(model.color_Id!) ,
                                                 imageArray: carImageArray,
                                                 docsArray: docsImageArray)
                    }
//                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: errorMessage, buttons: ["OK"])
                return
            }
        }
        
        self.dispatchGroup.notify(queue: .main) {
            AlertViewController.openAlertView(title: "Success", message: "SuperCars Updated Successfully!", buttons: ["OK"]) { (index) in
//                self.callGetSuperCarsListAPI()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

/*
 MARK: - ManagerSuperCarsViewController- UITableView
 */
extension ManagerSuperCarsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.dataArray.count == indexPath.row{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SupercarsFooterTableViewCell") as! SupercarsFooterTableViewCell
            cell.btnAddMore.addTarget(self, action: #selector(btnAddTargetTapped(sender:)), for: .touchUpInside)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SupercarsTableViewCell") as! SupercarsTableViewCell
            cell.setUpCell(index: indexPath.row, type: .register, model: self.dataArray[indexPath.row])
            
            //SETUP DELETE BUTTON
            if self.dataArray.count == 1{
                cell.btnDelete.isHidden = true
                cell.deleteheightConstraint.constant = 0
            }else{
                cell.btnDelete.isHidden = false
                cell.deleteheightConstraint.constant = 50
            }
            
            cell.btnBrand.tag = indexPath.row
            cell.btnModel.tag = indexPath.row
            cell.btnColor.tag = indexPath.row
            cell.btnUploadFront.tag = indexPath.row
            cell.btnUploadBack.tag = indexPath.row
            cell.btnUploadCar.tag = indexPath.row
            cell.btnCrossFront.tag = indexPath.row
            cell.btnCrossBack.tag = indexPath.row
            cell.btnCrossCar.tag = indexPath.row
            cell.btnDelete.tag = indexPath.row
            
            cell.btnBrand.addTarget(self, action: #selector(btnBrandTapped(sender:)), for: .touchUpInside)
            cell.btnModel.addTarget(self, action: #selector(btnModelTapped(sender:)), for: .touchUpInside)
            cell.btnColor.addTarget(self, action: #selector(btnColorTapped(sender:)), for: .touchUpInside)
            cell.btnUploadFront.addTarget(self, action: #selector(btnCRFrontTapped(sender:)), for: .touchUpInside)
            cell.btnUploadBack.addTarget(self, action: #selector(btnCRBackTapped(sender:)), for: .touchUpInside)
            cell.btnUploadCar.addTarget(self, action: #selector(btnCarImageTapped(sender:)), for: .touchUpInside)
            cell.btnCrossFront.addTarget(self, action: #selector(btnCrossFrontTapped(sender:)), for: .touchUpInside)
            cell.btnCrossBack.addTarget(self, action: #selector(btnCrossBackTapped(sender:)), for: .touchUpInside)
            cell.btnCrossCar.addTarget(self, action: #selector(btnCrossCarImageTapped(sender:)), for: .touchUpInside)
            cell.btnDelete.addTarget(self, action: #selector(btnDeleteTapped(sender:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func btnAddTargetTapped(sender: UIButton){
        self.dataArray.append(SupercarsModel())
        self.tableView.reloadData()
    }
    
    @objc func btnBrandTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        PickerViewController.openPickerView(type: .brand, title: "Brand", lastSelectedValue: model.brand ?? "") { (value, index) in
            model.brand = value
            model.brand_Id = index ?? 0
            
            model.model = ""
            model.model_Id =  0
            
            model.color = ""
            model.color_Id =  0
            
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
//            
//            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
//            self.tableView.reloadRows(at: [IndexPath(row: sender.tag + 2, section: 0)], with: .none)
        }
    }
    
    @objc func btnModelTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        if model.brand_Id ?? 0 == 0{
            AlertViewController.openAlertView(title: "Error", message: "Please select Brand!", buttons: ["OK"])
        }else{
            PickerViewController.openPickerView(type: .model, title: "Model", lastSelectedValue: model.brand ?? "", lastSelectedIndex: "\(model.brand_Id ?? 0)") { (value, index) in
                model.model = value
                model.model_Id = index ?? 0
                self.dataArray[sender.tag] = model
                self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
            }
        }
    }
    
    @objc func btnColorTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        PickerViewController.openPickerView(type: .color, title: "Color", lastSelectedValue: model.color ?? "") { (value, index) in
            model.color = value
            model.color_Id = index ?? 0
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    @objc func btnCRFrontTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        if model.carRegistraionFrontImageURL == nil && model.carRegistraionFrontImage == nil{
            ImagePicker.openImagePicker { (image) in
                model.carRegistraionFrontImage = image
                model.isCarRegistraionFrontImageEdit = true
                self.dataArray[sender.tag] = model
                self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
            }
        }
    }
    
    @objc func btnCRBackTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        if model.carRegistraionBackImageURL == nil && model.carRegistraionBackImage == nil{
            ImagePicker.openImagePicker { (image) in
                model.carRegistraionBackImage = image
                model.isCarRegistraionBackImageEdit = true
                self.dataArray[sender.tag] = model
                self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
            }
        }
    }
    
    @objc func btnCarImageTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        if model.carImageURL == nil && model.carImage == nil{
            ImagePicker.openImagePicker { (image) in
                model.carImage = image
                model.isCarImageEdit = true
                self.dataArray[sender.tag] = model
                self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
            }
        }
    }
    
    @objc func btnCrossFrontTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        model.carRegistraionFrontImage = nil
        model.carRegistraionFrontImageURL = nil
        model.isCarRegistraionFrontImageEdit = true
        var array: [String] = []
        array.append(model.carRegistraionFront_Id ?? "")
        model.deleted_Doc_Array = (model.deleted_Doc_Array ?? []) + array
        self.dataArray[sender.tag] = model
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @objc func btnCrossBackTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        model.carRegistraionBackImage = nil
        model.isCarRegistraionBackImageEdit = true
        model.carRegistraionBackImageURL = nil
        var array: [String] = []
        array.append(model.carRegistraionBack_Id ?? "")
        model.deleted_Doc_Array = (model.deleted_Doc_Array ?? []) + array
        self.dataArray[sender.tag] = model
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @objc func btnCrossCarImageTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        model.carImage = nil
        model.isCarImageEdit = true
        model.carImageURL = nil
        var array: [String] = []
        array.append(model.carImage_Id ?? "")
        model.deleted_Car_Array = (model.deleted_Car_Array ?? []) + array
        self.dataArray[sender.tag] = model
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @objc func btnDeleteTapped(sender: UIButton){
        let model = self.dataArray[sender.tag]
        if model.car_Id != nil{
            AlertViewController.openAlertView(title: "Warning", message: String(format: "Are you sure you want to delete %@ %@", model.brand ?? "", model.model ?? ""), buttons: ["Cancle", "Delete"]) { (index) in
                if index == 0{
                    
                }else{
                    self.callDeleteSupercarAPI(carId: model.car_Id ?? "")
                }
            }
        }else{
            self.dataArray.remove(at: sender.tag)
        }
        self.tableView.reloadData()
    }
}

