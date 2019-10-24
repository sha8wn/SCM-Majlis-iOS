//
//  PickerViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 27/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

enum PickerType{
    case model
    case brand
    case color
}

class PickerViewController: UIViewController {
    
    /*
     MARK: Properties
     */
    @IBOutlet weak var btnSearch        : UIButton!
    @IBOutlet weak var btnBack          : UIButton!
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var lblNoData        : UILabel!
    @IBOutlet weak var searchBar        : UISearchBar!
    @IBOutlet weak var tableView        : UITableView!
    var titleString                     : String        = ""
    var dataArray                       : [String]      = []
    var searchArray                     : [String]      = []
    var searchActive                    : Bool          = false
    var selectedIndex                   : Int!
    var lastSelectedValue               : String        = ""
    var model                           : [Any]         = []
    var pickerType                      : PickerType!
    private var pickerDoneBlock         : PickerDone!
    internal typealias PickerDone                       = (_ value: String, _ index : Int?) -> Void
    
    static let sharedInstance           : PickerViewController = {
        let instance = Constants.commonStoryboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        return instance
    }()
    
    //end
    
    /*
     MARK: UIViewController Life Cycle
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        self.searchBar.delegate = self
        self.searchBar.isHidden = true
    }
    
    class func openPickerView(dataArray: [String], title: String, lastSelectedValue: String? = "", completionHandler: @escaping PickerDone) {
        
        PickerViewController.sharedInstance.pickerDoneBlock = completionHandler
        
        PickerViewController.sharedInstance.openPicker(dataArray: dataArray, title: title, lastSelectedValue: lastSelectedValue, completionHandler: completionHandler)
    }
    
    class func openPickerView(type: PickerType, title: String, lastSelectedValue: String? = "", lastSelectedIndex: String? = "", completionHandler: @escaping PickerDone) {
        
        PickerViewController.sharedInstance.pickerDoneBlock = completionHandler
        
        PickerViewController.sharedInstance.openPicker(type: type, title: title, lastSelectedValue: lastSelectedValue, lastSelectedIndex: lastSelectedIndex, completionHandler: completionHandler)
    }
    
    func openPicker(dataArray: [String], title: String, lastSelectedValue: String? = "", completionHandler: @escaping PickerDone){
        
        guard let rootVC = Constants.kAppDelegate.window?.rootViewController else {
            return
        }
        
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        rootVC.present(self, animated: true, completion: nil)
        
        self.dataArray = dataArray
        
        self.lblTitle.text = title
        
        self.searchBar.isHidden = true
        
        self.searchActive = false
        
        self.selectedIndex = nil
        
        if let val = lastSelectedValue {
            if val == ""{
                self.selectedIndex = nil
            }else{
                self.selectedIndex = self.dataArray.firstIndex(of: val)
            }
        }else{
            self.selectedIndex = nil
        }
        
        self.tableView.reloadData()
    }
    
    func openPicker(type: PickerType, title: String, lastSelectedValue: String? = "", lastSelectedIndex: String? = "", completionHandler: @escaping PickerDone){
        
        guard let rootVC = Constants.kAppDelegate.window?.rootViewController else {
            return
        }
        
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        rootVC.present(self, animated: true, completion: nil)
        
        self.dataArray = []
        
        self.pickerType = type
        
        self.lblNoData.isHidden = true
        
        self.lblTitle.text = title
        
        self.searchBar.isHidden = true
        
        self.searchActive = false
        
        self.selectedIndex = nil
        
        self.lastSelectedValue = lastSelectedValue ?? ""
        
        self.tableView.reloadData()
        
        if type == .brand{
            self.getBrands()
        }else if type == .model{
            self.getModels(brandId: lastSelectedIndex!)
        }else if type == .color{
            self.getColors()
        }
        
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSearchTapped(_ sender: Any) {
        if self.searchBar.isHidden == true{
            self.searchBar.isHidden = false
            self.searchBar.becomeFirstResponder()
        }else{
            self.searchBar.isHidden = true
            self.searchBar.resignFirstResponder()
        }
    }
}

/*
 MARK: - PickerViewController: UITableView Delegate and DataSource
 */

extension PickerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchActive {
            if searchArray.count > 0{
                self.lblNoData.isHidden = true
            }else{
                self.lblNoData.isHidden = false
            }
            return searchArray.count
        }else{
            if dataArray.count > 0{
                self.lblNoData.isHidden = true
            }else{
                self.lblNoData.isHidden = false
            }
            return dataArray.count
        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 80
    //    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PickerTableViewCell", for: indexPath) as? PickerTableViewCell
        {
            if self.searchActive {
                cell.lblTitle.text = self.searchArray[indexPath.row]
            }else{
                cell.lblTitle.text = self.dataArray[indexPath.row]
            }
            
            if self.selectedIndex != nil{
                if self.selectedIndex == indexPath.row{
                    cell.imgTick.isHidden = false
                }else{
                    cell.imgTick.isHidden = true
                }
            }else{
                cell.imgTick.isHidden = true
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedValue: String = ""
        if self.searchActive{
            selectedValue = self.searchArray[indexPath.row]
        }else{
            selectedValue = self.dataArray[indexPath.row]
        }
        
        if self.pickerType == .brand{
            var id: Int!
            for i in 0..<self.model.count{
                let model = self.model[i] as! BrandList
                print(model)
                if model.name == selectedValue{
//                    id = Int(model.id ?? "0")!
                    id = model.id ?? 0
                }
            }
            self.pickerDoneBlock(selectedValue, id)
        }else if self.pickerType == .model{
            var id: Int!
            for i in 0..<self.model.count{
                let model = self.model[i] as! ModelList
                print(model)
                if model.name == selectedValue{
//                    id = Int(model.id ?? "0")!
                    id = model.id ?? 0
                }
            }
            self.pickerDoneBlock(selectedValue, id)
        }else if self.pickerType == .color{
            var id: Int!
            for i in 0..<self.model.count{
                let model = self.model[i] as! CarColorsList
                print(model)
                if model.name == selectedValue{
//                    id = Int(model.id ?? "0")!
                    id = model.id ?? 0
                }
            }
            self.pickerDoneBlock(selectedValue, id)
        }else{
            self.pickerDoneBlock(selectedValue, self.dataArray.firstIndex(of: selectedValue))
        }
        self.dismiss(animated: true, completion: nil)        
    }
    
}
//end

/*
 MARK: - Search Bar Delegate
 */
extension PickerViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        self.searchActive = false
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchArray = []
        DispatchQueue.main.async {
            if searchText == ""{
                searchBar.resignFirstResponder()
                searchBar.text = ""
                searchBar.setShowsCancelButton(false, animated: true)
                self.searchActive = false
                self.tableView.reloadData()
            }else{
                if self.dataArray.count > 0{
                    for str in self.dataArray{
                        if str.lowercased().contains(searchText.lowercased()){
                            self.searchArray.append(str)
                        }
                        self.searchActive = true
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}


/*
 MARK: - PickerViewController: UITableViewCell
 */
class PickerTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgTick: UIImageView!
}

/*
 MARK: - PickerViewController: Webservice
 */
extension PickerViewController{
    func getBrands(){
        
        self.lblNoData.isHidden = true
        
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetCarBrandsAPI
        
        Network.shared.request(urlPath: urlPath, methods: .get, authType: .basic) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(CarBrands.self, from: response?.data ?? Data())
                    if let brands = responseModel.brands{
                        if let list = brands.list{
                            if list.count > 0{
                                self.lblNoData.isHidden = true
                                
                                var array: [String] = []
                                for model in list{
                                    array.append(model.name ?? "")
                                }
                                
                                self.model = list
                                
                                self.dataArray = array
                                
                                if self.lastSelectedValue == ""{
                                    self.selectedIndex = nil
                                }else{
                                    self.selectedIndex = self.dataArray.firstIndex(of: self.lastSelectedValue)
                                }
                                
                                self.tableView.reloadData()
                            }else{
                                self.lblNoData.isHidden = false
                            }
                        }else{
                            self.lblNoData.isHidden = false
                        }
                    }else{
                        self.lblNoData.isHidden = false
                    }
                } catch let error {
                    print(error)
                    self.lblNoData.isHidden = false
                }
            }else{
                self.lblNoData.isHidden = false
            }
        }
    }
    
    func getModels(brandId: String){
        
        self.lblNoData.isHidden = true
        
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetCarModelsAPI + "?brand=" + "\(brandId)"
        
        Network.shared.request(urlPath: urlPath, methods: .get, authType: .basic) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(CarModels.self, from: response?.data ?? Data())
                    if let brands = responseModel.models{
                        if let list = brands.list{
                            if list.count > 0{
                                self.lblNoData.isHidden = true
                                
                                var array: [String] = []
                                for model in list{
                                    array.append(model.name ?? "")
                                }
                                
                                self.model = list
                                
                                self.dataArray = array
                                
                                if self.lastSelectedValue == ""{
                                    self.selectedIndex = nil
                                }else{
                                    self.selectedIndex = self.dataArray.firstIndex(of: self.lastSelectedValue)
                                }
                                
                                self.tableView.reloadData()
                            }else{
                                self.lblNoData.isHidden = false
                            }
                        }else{
                            self.lblNoData.isHidden = false
                        }
                    }else{
                        self.lblNoData.isHidden = false
                    }
                } catch let error {
                    print(error)
                    self.lblNoData.isHidden = false
                }
            }else{
                self.lblNoData.isHidden = false
            }
        }
    }
    
    func getColors(){
        
        self.lblNoData.isHidden = true
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetCarColorAPI
        
        Network.shared.request(urlPath: urlPath, methods: .get, authType: .auth) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(CarColorsModel.self, from: response?.data ?? Data())
                    if let colors = responseModel.colors{
                        if let list = colors.list{
                            if list.count > 0{
                                self.lblNoData.isHidden = true
                                
                                var array: [String] = []
                                for model in list{
                                    array.append(model.name ?? "")
                                }
                                
                                self.model = list
                                
                                self.dataArray = array
                                
                                if self.lastSelectedValue == ""{
                                    self.selectedIndex = nil
                                }else{
                                    self.selectedIndex = self.dataArray.firstIndex(of: self.lastSelectedValue)
                                }
                                
                                self.tableView.reloadData()
                            }else{
                                self.lblNoData.isHidden = false
                            }
                        }else{
                            self.lblNoData.isHidden = false
                        }
                    }else{
                        self.lblNoData.isHidden = false
                    }
                } catch let error {
                    print(error)
                    self.lblNoData.isHidden = false
                }
            }else{
                self.lblNoData.isHidden = false
            }
        }
    }
}
