//
//  FileHandleViewController.swift
//  TopicDemos
//
//  Created by Max Wang on 4/14/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import AVFoundation

class FileHandleViewController: UIViewController {
    var players = [AVAudioPlayer]()
    override func viewDidLoad() {
        super.viewDidLoad()
       // unsigned long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:someFilePath error:nil] fileSize];
        if let path = Bundle.main.path(forResource: "SL_intro", ofType: ".mp3") {
            
            let size: Int = try! FileManager.default.attributesOfItem(atPath: path)[FileAttributeKey.size] as! Int
            print(size)
            let fh = FileHandle(forReadingAtPath: path)!
            var read = 0
            var totalData: NSData? = nil
            while read < size {
                fh.seek(toFileOffset: UInt64(read))
                let data = fh.readData(ofLength: 10000)
                print(data)
//                if totalData == nil {
//                    totalData = data as NSData?
//                } else {
//                    totalData += data
//                }
                if let player = try? AVAudioPlayer(data: data, fileTypeHint: "mp3") {
                    players.append(player)
                    player.play()
                }
                read += data.count
                print("Read ------------ \(read)")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
