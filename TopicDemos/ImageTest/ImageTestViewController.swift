//
//  ImageTestViewController.swift
//  TopicDemos
//
//  Created by Max Wang on 2/24/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import SDWebImage

class ImageTestViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    
    
    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView.layer.contentsScale = UIScreen.main.scale
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {[weak self] (timer)  in
                //self is nil
                self?.updateImage()
            }
        } else {
            // Fallback on earlier versions
        }
        
        loadImage()
    }
    //MARK: rotate image
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
        print("index \(index) counter \(counter) imagename: \(imageName) \(String(describing: imageView.image))")
    }
    //MARK: aspectFill from top image resizing
    //http://nshipster.com/image-resizing/
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
    //MARK: Associated Object
    
    @IBOutlet weak var remoteImageView: UIImageView!
    func loadImage() {
        let imageUrlString = "https://static.pexels.com/photos/51099/pexels-photo-51099.jpeg"
        remoteImageView.setupSdWebImageManger()
        remoteImageView.loadImageIfPossible(urlString: imageUrlString)
    }
}

extension UIImageView {
    func setupSdWebImageManger() {
        let manager = SDWebImageManager.shared()
        self.fetcher = manager
    }
    func loadImageIfPossible(urlString: String) {
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        if let fetcher = self.fetcher as? SDWebImageManager {
            fetcher.downloadImage(with: url, options: .allowInvalidSSLCertificates, progress: nil, completed: { (image, err, cacheType, resBool, url) in
                self.image = image
            })
        } else {
            print("not set fetcher using associated object")
        }
    }
    struct AssciateObjectKey {
        static var SDWebImageManagerKey = "SDWebImageManagerKey"
    }
    var fetcher: AnyObject? {
        get {
            return objc_getAssociatedObject(self, &AssciateObjectKey.SDWebImageManagerKey) as AnyObject?
        }
        set {
            objc_setAssociatedObject(self, &AssciateObjectKey.SDWebImageManagerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}


