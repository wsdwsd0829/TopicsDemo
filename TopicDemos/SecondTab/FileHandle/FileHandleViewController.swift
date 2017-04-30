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
        FileHandle.readFile(name: "SL_intro", type: ".mp3") { data in
            if let player = try? AVAudioPlayer(data: data, fileTypeHint: "mp3") {
                players.append(player)
                player.play()
            }
        }
    }
}
