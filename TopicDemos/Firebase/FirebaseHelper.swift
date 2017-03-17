//
//  FirebaseHelper.swift
//  TopicDemos
//
//  Created by Sida Wang on 2/26/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import Firebase

@objc protocol AuthDelegate {
    func didLogin(_ user: FIRUser)
}
extension AppDelegate: AuthDelegate {

    func didLogin(_ user: FIRUser) {
        testSaveAndFetch(user)
    }
    func testSaveAndFetch(_ user: FIRUser) {
        let montage1 = Montage()
        montage1.author = "Kei Sakaguchi"
        montage1.yt_url = "https://www.youtube.com/watch?v=joucE2oAYDY"
        montage1.desc = "This is a test."
        montage1.title = "Kei goes to Dev Camp!"
        montage1.montage_id = "1234ABCD"
        let clip1 = Clip(startTime: 10, endTime: 20, thumbNailUrl: nil)
        let clip2 = Clip(startTime: 20, endTime: 30, thumbNailUrl: nil)
        montage1.clips = [clip1, clip2]
        
        let montage2 = Montage()
        montage2.author = "Max"
        montage2.yt_url = "https://www.youtube.com/watch?v=nS-rnG_DGHA"
        montage2.desc = "This is another test."
        montage2.title = "MAX!"
        montage2.montage_id = "1111AAAA"
        let clip3 = Clip(startTime: 10, endTime: 20, thumbNailUrl: nil)
        let clip4 = Clip(startTime: 20, endTime: 30, thumbNailUrl: nil)
        
        montage2.clips = [clip3, clip4]
        
        
        //test save image
        clip3.thumbnailNameId = UUID().uuidString
        let placeholderImage = UIImage(named: "placeholder")
        guard let data = UIImagePNGRepresentation(placeholderImage!) else {
            fatalError("convert to png data err")
        }
        
        networkService.saveImage(data, withName: "\(clip3.thumbnailNameId).png", completionHandler: { (downloadUrlStr ,err) in
            if let durl = downloadUrlStr {
                clip3.thumbnail_url = durl
                self.networkService.addMontage(montage: montage2, user_id: user.uid, completionHandler: { (err) in
                    if err != nil {
                        print(err!)
                    }
                })
            } else {
                print(err?.localizedDescription ?? "")
            }
        })
        //test saving
        networkService.addMontage(montage: montage1, user_id: user.uid) { (error) in
            if error != nil {
                print("fail")
                return
            }
            print("yay, it worked")
            self.networkService.fetchMontages(user_id: user.uid) { (montages, err) in
                montages.forEach({
                    print($0)
                })
            }
            
        }
    }
}


