//
//  WelcomeViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 26/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import AVFoundation


class WelcomeViewController: UIViewController {

    /*
     MARK: - Properties
     */
    @IBOutlet var btnStart: UIButton!
    @IBOutlet var imgView: UIImageView!
    var videoPlayer: AVPlayer!
    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        DispatchQueue.main.async {
            let image = self.createThumbnailOfVideoFromRemoteUrl()
            self.imgView.image = image
        }
    }
    
    func createThumbnailOfVideoFromRemoteUrl() -> UIImage? {
        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else { return UIImage()
        }
        
        let asset = AVAsset(url: URL(fileURLWithPath: path))
        
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
          print(error.localizedDescription)
          return nil
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

    @IBAction func btnStartTapped(sender: UIButton){
        
        self.btnStart.isUserInteractionEnabled = false
        
        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        self.videoPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        var playerLayer: AVPlayerLayer?
        playerLayer = AVPlayerLayer(player: self.videoPlayer)
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer!.frame = self.imgView.frame
        self.view!.layer.addSublayer(playerLayer!)
        self.videoPlayer.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(note:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer.currentItem)

        
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        let viewController = Constants.loginAndSignupStoryboard.instantiateViewController(withIdentifier: "ChooseUserTypeViewController") as! ChooseUserTypeViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
