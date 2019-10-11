//
//  WalkthroughParentViewController.swift
//  Nibou
//
//  Created by Ongraph on 5/8/19.
//  Copyright © 2019 OnGraph. All rights reserved.
//

import UIKit

class WalkthroughParentViewController: UIViewController {

    /**
     MARK: - Properties
     */
    @IBOutlet weak var scrollView       : UIScrollView!
    @IBOutlet weak var btnNext          : UIButton!
    @IBOutlet weak var pageControl      : UIPageControl!
    var pageArray                       : Array<Any>!
    var count                           : Int!
    var xOffSet                         : Int = 0
    //end
    
    /**
     MARK: - All View Will Load Here
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets.zero;
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        self.scrollView.frame = self.view.frame
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.size.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setUpWalkthroughView()
    }
    
    
    
    /**
     MARK: - Set up WalkthroughView function
     */
    func setUpWalkthroughView(){
        //Set up scrollView
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false

        let dictView1 = ["imageDesc" : "Many brands, one passion.\nSuper Cars",
                         "imageURL"  : "ic_ScreenA",
                         "title"     : "Welcome to\nSuperCars Majlis"]
        
        let dictView2 = ["imageDesc" : "Get notified about the latest events and RSVP to them ysing the app",
                         "imageURL"  : "ic_ScreenB",
                         "title"     : "Events"]
        
        let dictView3 = ["imageDesc" : "Get connected to our partners and ger exclusive offers available only to SCM members.",
                         "imageURL"  : "ic_ScreenC",
                         "title"     : "Promotions"]
   
        self.pageArray = [dictView1, dictView2, dictView3]
        

        self.count = 0
        var xAsix : CGFloat = 0.0
        for i in 0  ..< self.pageArray.count  {
            let Views = UIView()
            Views.frame = CGRect(x: xAsix, y: 0.0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            let introDict = pageArray[i] as! NSDictionary
            let viewControl = getViewOfWalkthrough(dict: introDict, index: i) as UIViewController
            Views.addSubview(viewControl.view)
            self.scrollView.addSubview(Views)
            xAsix = xAsix + self.view.frame.width
        }
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(self.pageArray.count), height: self.scrollView.frame.size.height)
        self.pageControl.numberOfPages = self.pageArray.count
    }

    
    /**
     MARK: - Get View Of Walkthrough
     - Function to Get and Set View Controller on UIScrollView
     - Returns: WalkthroughViewController
     */
    func getViewOfWalkthrough(dict: NSDictionary, index: Int) -> WalkthroughViewController{
        let vc = Constants.walkthroughStoryboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as! WalkthroughViewController
        vc.imageUrl = dict.value(forKey: "imageURL") as! String
        vc.titleStr = dict.value(forKey: "title") as! String
        vc.descStr = dict.value(forKey: "imageDesc") as! String
        return vc
    }
    
    /**
     MARK: - Button Next Tapped
     */
    @IBAction func btnNextTapped(){
        if self.count == self.pageArray.count - 1{
            let viewController = Constants.walkthroughStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }else{
            if(self.pageArray.count != self.count){
                xOffSet = self.count * Int(self.view.frame.width)
                self.count = self.count + 1
                UIView.animate(withDuration: 0.5) {
                    self.scrollView.contentOffset = CGPoint(x: self.scrollView.frame.size.width * CGFloat(self.count), y: 0)
                    self.pageControl.currentPage = self.count
                }
            }else{
            }
        }
    }

}
//end

/**
 MARK: - Extension of WalkthroughViewController with UIScrollViewDelegate
*/
extension WalkthroughParentViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.pageArray != nil{
            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(self.pageArray.count), height: self.scrollView.frame.size.height)
            self.pageControl.numberOfPages = self.pageArray.count
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page : Int = Int(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)
        xOffSet = page * Int(self.view.frame.width)
        self.pageControl.currentPage = page
        self.count = page
    }
}
//end
