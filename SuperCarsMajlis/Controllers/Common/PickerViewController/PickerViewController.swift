//
//  PickerViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 27/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

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
    
    func openPicker( dataArray: [String], title: String, lastSelectedValue: String? = "", completionHandler: @escaping PickerDone){
        
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
                
        self.pickerDoneBlock(selectedValue, self.dataArray.firstIndex(of: selectedValue))
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
