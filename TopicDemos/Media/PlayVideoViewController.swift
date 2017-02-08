//
//  PlayVideoViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 2/8/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import AVKit
import AVFoundation

/**
 TODO: 
 cache video, replay
 */

class PlayVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //comment following section to use button & segue
        if let url = URL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov") {
            let player = AVPlayer(url: url)
            let playerController = AVPlayerViewController()
            
            playerController.player = player
            self.addChildViewController(playerController)
            self.view.addSubview(playerController.view)
            playerController.view.frame = self.view.frame
            
            player.play()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playClicked(_ sender: UIButton) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let pvc = segue.destination as? AVPlayerViewController, let url = URL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov") {
            let player = AVPlayer(url: url)
            pvc.player = player
        }
    }
}
