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
    var audioPlayer       : AVAudioPlayer?

    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.audioPlayer?.delegate = self
        // Do any additional setup after loading the view.
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
        guard let url = Bundle.main.url(forResource: "start", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer?.delegate = self
            audioPlayer?.play()
        }catch let error{
            print(error.localizedDescription)
        }
    }
}

extension WelcomeViewController: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let viewController = Constants.loginAndSignupStoryboard.instantiateViewController(withIdentifier: "ChooseUserTypeViewController") as! ChooseUserTypeViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
