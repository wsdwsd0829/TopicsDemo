//
//  ImageTestViewController.swift
//  TopicDemos
//
//  Created by Max Wang on 2/24/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class ImageTestViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    var counter = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView.layer.contentsScale = UIScreen.main.scale
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {[weak self] (timer)  in
            //self is nil
            self?.updateImage()
        }
    }
    func updateImage() {
        let images = ["test2.jpg", "landscape.jpg", "portrait.jpg", "test.jpg"];
        let index = counter%images.count
        let imageName = images[index]
        counter = counter + 1
        
        guard let image = UIImage(named: imageName) else {
            return
        }
        imageView.contentMode = .top
        imageView.clipsToBounds = true
        let newImage = aspectFillImageFrom(image: image, frame:
        imageView.frame)
        imageView.image = newImage
        print("index \(index) counter \(counter) imagename: \(imageName) \(imageView.image)")
    }
    
    func aspectFillImageFrom(image: UIImage, frame: CGRect) -> UIImage? {
        var scaleRatio: CGFloat = 0
        //image too wide, scale height to chop left/right
        if image.size.width/image.size.height > frame.size.width/frame.size.height {
            scaleRatio = imageView.frame.size.height/image.size.height
        } else { //image too high, scale width to chop top/bottom
            scaleRatio = imageView.frame.size.width/image.size.width
        }
        
        let size = image.size.applying(CGAffineTransform(scaleX: scaleRatio, y: scaleRatio))
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    

}
