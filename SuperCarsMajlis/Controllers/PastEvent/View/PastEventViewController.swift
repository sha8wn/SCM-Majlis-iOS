//
//  PastEventViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 26/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SKPhotoBrowser

enum PastEvent{
    case chooseUser
    case home
}

class PastEventViewController: UIViewController {
    /*
     MARK: - Properties
     */
    @IBOutlet var btnLogin              : UIButton!
    @IBOutlet var btnBack               : UIButton!
    @IBOutlet var tableView             : UITableView!
    @IBOutlet weak var lbl_NoData       : UILabel!
    @IBOutlet var loginHeightConstraint : NSLayoutConstraint!
    @IBOutlet var titleTopConstraint    : NSLayoutConstraint!
    var openFrom                        : PastEvent!
    var dataArray                       : [PastEventList]  = []
    var totalRecord                     : Int                   = 0
    var pageNumber                      : Int                   = 1
    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPastEventAPI(page: 1)
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView(){
        //Register TableView Cell
        self.tableView.register(UINib(nibName: "PastEventTableViewCell", bundle: nil), forCellReuseIdentifier: "PastEventTableViewCell")
        
        if self.openFrom == .chooseUser{
            self.btnLogin.isHidden = false
            self.loginHeightConstraint.constant = 55
            self.titleTopConstraint.constant = 30
            self.btnBack.isHidden = true
        }else{
            self.btnLogin.isHidden = true
            self.loginHeightConstraint.constant = 0
            self.titleTopConstraint.constant = 60
            self.btnBack.isHidden = false
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
    @IBAction func btnLoginTapped(_ sender: UIButton){
        let viewController = Constants.loginAndSignupStoryboard.instantiateViewController(withIdentifier: "ChooseUserTypeViewController") as! ChooseUserTypeViewController
        self.navigationController?.pushViewController( viewController, animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

/*
 MARK: - PastEventViewController- UITableViewDelegate and DataSource
 */
extension PastEventViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataArray.count > 0{
            return self.dataArray.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.openFrom == .chooseUser{
            return 100
        }else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PastEventTableViewCell", for: indexPath) as! PastEventTableViewCell
        cell.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
        cell.setupCell(model: self.dataArray[indexPath.row])
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
    
}
//end

/*
 MARK: - PastEventViewController- PastEventDelegate
 */
extension PastEventViewController: PastEventDelegate{
    func eventSelected(index: Int, imageArray: [PastEventImages]) {
        var images = [SKPhoto]()
        for imageData in imageArray{
            let photo = SKPhoto.photoWithImageURL(imageData.img ?? "")
            photo.shouldCachePhotoURLImage = true
            images.append(photo)
        }
        // 2. create PhotoBrowser Instance, and present.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(index)
        present(browser, animated: true, completion: {})
    }
}

//MARK: - UIScrollView Delegate
extension PastEventViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(self.dataArray.count > 0){
            if self.totalRecord > self.dataArray.count{
                self.pageNumber = self.pageNumber + 1
                self.getPastEventAPI(page: self.pageNumber)
            }
        }
    }
}
// end
