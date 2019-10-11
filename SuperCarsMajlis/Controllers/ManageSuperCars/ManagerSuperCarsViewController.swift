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
    @IBOutlet var btnBack             : UIButton!
    @IBOutlet var btnSave             : UIButton!
    @IBOutlet var tableView           : UITableView!
    var dataArray                     : [SupercarsModel]   = [SupercarsModel()]
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
        self.tableView.register(UINib(nibName: "SupercarsFooterTableViewCell", bundle: nil), forCellReuseIdentifier: "SupercarsFooterTableViewCell")
        self.tableView.register(UINib(nibName: "SupercarsTableViewCell", bundle: nil), forCellReuseIdentifier: "SupercarsTableViewCell")
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
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        AlertViewController.openAlertView(title: "Success", message: "SuperCars Updated Successfully!", buttons: ["OK"])
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
        PickerViewController.openPickerView(dataArray: ["1", "2", "3", "4", "5", "6", "7"], title: "Brand", lastSelectedValue: model.brand ?? "") { (value, index) in
            print(value)
            model.brand = value
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    @objc func btnModelTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        PickerViewController.openPickerView(dataArray: ["ABC", "ABCD", "ABCDE", "ABCDEF", "ABCDEFG", "ABCDEFGH", "ABCDEFGHI"], title: "Brand", lastSelectedValue: model.model ?? "") { (value, index) in
            print(value)
            model.model = value
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    @objc func btnColorTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        PickerViewController.openPickerView(dataArray: ["Red", "Blue", "White", "Black", "Silver"], title: "Color", lastSelectedValue: model.color ?? "") { (value, index) in
            print(value)
            model.color = value
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    @objc func btnCRFrontTapped(sender: UIButton){
        ImagePicker.openImagePicker { (image) in
            var model = self.dataArray[sender.tag]
            model.carRegistraionFrontImage = image
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    @objc func btnCRBackTapped(sender: UIButton){
        ImagePicker.openImagePicker { (image) in
            var model = self.dataArray[sender.tag]
            model.carRegistraionBackImage = image
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    @objc func btnCarImageTapped(sender: UIButton){
        ImagePicker.openImagePicker { (image) in
            var model = self.dataArray[sender.tag]
            model.carImage = image
            self.dataArray[sender.tag] = model
            self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    @objc func btnCrossFrontTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        model.carRegistraionFrontImage = nil
        self.dataArray[sender.tag] = model
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @objc func btnCrossBackTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        model.carRegistraionBackImage = nil
        self.dataArray[sender.tag] = model
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @objc func btnCrossCarImageTapped(sender: UIButton){
        var model = self.dataArray[sender.tag]
        model.carImage = nil
        self.dataArray[sender.tag] = model
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @objc func btnDeleteTapped(sender: UIButton){
        self.dataArray.remove(at: sender.tag)
        self.tableView.reloadData()
    }
}

