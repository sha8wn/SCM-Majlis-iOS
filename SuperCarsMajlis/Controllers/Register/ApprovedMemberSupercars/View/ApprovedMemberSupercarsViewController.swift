//
//  ApprovedMemberSupercarsViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 30/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import Photos

class ApprovedMemberSupercarsViewController: UIViewController {
    
    /*
     MARK: - Properties
     */
    @IBOutlet var btnBack             : UIButton!
    @IBOutlet var btnNext             : UIButton!
    @IBOutlet var tableView           : UITableView!
    var dispatchGroup                                      = DispatchGroup()
    var dataArray                     : [SupercarsModel]   = [SupercarsModel()]
    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.callGetSuperCarsListAPI()
        // Do any additional setup after loading the view.
    }
    
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
    
    @IBAction func btnNextTapped(_ sender: Any) {
        for model in self.dataArray{
            let (isValidate, errorMessage) = self.getValidate(model: model)
            if isValidate{
                if model.carRegistraionFrontImage == nil && model.carRegistraionBackImage == nil{
                }else{
                    if model.carRegistraionFrontImage != nil && model.carRegistraionBackImage != nil{
                        
                    }else{
                        AlertViewController.openAlertView(title: "Error", message: "Please Add Car Registration Document from both Side (Front and Back)", buttons: ["OK"])
                        break
                    }
                }
                
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
                                                brand_Id: Int(model.brand_Id!) ?? 0,
                                                model_Id: Int(model.model_Id!) ?? 0,
                                                color_Id: Int(model.color_Id!) ?? 0,
                                                imageArray: carImageArray,
                                                docsArray: docsImageArray)
                }else{
                    self.callAddSuperCarsAPI(brand_Id: Int(model.brand_Id!) ?? 0,
                                             model_Id: Int(model.model_Id!) ?? 0,
                                             color_Id: Int(model.color_Id!) ?? 0,
                                             imageArray: carImageArray,
                                             docsArray: docsImageArray)
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: errorMessage, buttons: ["OK"])
                break
            }
        }
        
        self.dispatchGroup.notify(queue: .main) {
            let vc = Constants.homeStoryboard.instantiateViewController( withIdentifier: "DocumentViewController") as! DocumentViewController
            vc.openFrom = .register
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}

/*
 MARK: - ApprovedMemberSupercarsViewController- UITableView
 */
extension ApprovedMemberSupercarsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.dataArray.count == indexPath.row{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SupercarsFooterTableViewCell") as! SupercarsFooterTableViewCell
            cell.btnAddMore.addTarget(self, action: #selector(btnAddTargetTapped(sender:)), for: .touchUpInside)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SupercarsTableViewCell") as! SupercarsTableViewCell
            cell.setUpCell(index: indexPath.row, type: .register, model: self.dataArray[indexPath.row])
            
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
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
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
        ImagePicker.openImagePicker { (image) in
            var model = self.dataArray[sender.tag]
            model.carRegistraionFrontImage = image
            model.isCarRegistraionFrontImageEdit = true
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    @objc func btnCRBackTapped(sender: UIButton){
        ImagePicker.openImagePicker { (image) in
            var model = self.dataArray[sender.tag]
            model.carRegistraionBackImage = image
            model.isCarRegistraionBackImageEdit = true
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    @objc func btnCarImageTapped(sender: UIButton){
        ImagePicker.openImagePicker { (image) in
            var model = self.dataArray[sender.tag]
            model.carImage = image
            model.isCarImageEdit = true
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    @objc func btnCrossFrontTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        model.carRegistraionFrontImage = nil
        model.isCarRegistraionFrontImageEdit = true
        self.dataArray[sender.tag] = model
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @objc func btnCrossBackTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        model.carRegistraionBackImage = nil
        model.isCarRegistraionBackImageEdit = true
        self.dataArray[sender.tag] = model
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @objc func btnCrossCarImageTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        model.carImage = nil
        model.isCarImageEdit = true
        self.dataArray[sender.tag] = model
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @objc func btnDeleteTapped(sender: UIButton){
        let model = self.dataArray[sender.tag]
        if model.car_Id != nil{
            
        }else{
            self.dataArray.remove(at: sender.tag)
        }
        self.tableView.reloadData()
    }
}

