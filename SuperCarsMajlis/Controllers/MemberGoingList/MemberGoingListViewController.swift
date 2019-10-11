//
//  MemberGoingListViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 07/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class MemberGoingListViewController: UIViewController {

    /*
     MARK: - Properties
     */
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoOfGoing: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    /*
     MARK: - SetUp View
     */
    func setUpView(){
        //Register TableView Cell
        self.tableView.register(UINib(nibName: "MemberGoingTableViewCell", bundle: nil), forCellReuseIdentifier: "MemberGoingTableViewCell")
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
    
}

/*
MARK: - MemberGoingListViewController: UITableViewDelegate and UITableViewDataSource
*/
extension MemberGoingListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberGoingTableViewCell", for: indexPath) as! MemberGoingTableViewCell
        return cell
    }

}
