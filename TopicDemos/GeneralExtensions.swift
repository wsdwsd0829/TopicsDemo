//
//  Extensions.swift
//  PinVid
//
//  Created by Sida Wang on 2/25/17.
//  Copyright © 2017 SantaClaraiOSConnect. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    var snapshotImage: UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size);
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return viewImage;
    }
    
    var snapshotImageIOS10: UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
            let image = renderer.image { ctx in
                self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            }
            return image
        }
        return nil
    }
}

public enum InstantiateType {
    case storyboard, nib
}
public protocol ViewControllerInstantiable {
    //set id in storyboard, and call this
    static func instantiateX(controllerType type: UIViewController.Type, _ instantiateType: InstantiateType) -> UIViewController;
}

extension UIViewController: ViewControllerInstantiable {
    public static func instantiateX(controllerType type: UIViewController.Type, _ instantiateType: InstantiateType = .storyboard) -> UIViewController {
        let controllerName = String(describing: type.self)
        guard let controllerEnum = Controllers.init(rawValue: controllerName) else {
            fatalError("Busted!!: no such controller defined")
        }
        switch instantiateType {
        case .storyboard:
            
            let storyboard = UIStoryboard(name: controllerEnum.storyboardName, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: controllerEnum.identifier) //cast back to what you want
            return vc
        case .nib:
            let avc = type.init(nibName: controllerName , bundle: nil)
            return avc
        }
    }
}

//Template
public enum Controllers: String {
    //capitalize on purpose to use rawdata as id
    //Frist Tab
    case ProfileListViewController, EmailViewController, YouTubeViewController, CreateClipsViewController, DetailViewController, ViewController
    //Second Tab
    case PromiseKitViewController, UITestingViewController, AccessibilityViewController, NavigationViewController, FileHandleViewController, TransitePresentStyleViewController, CustomPresentAnimateViewController, CoreDataViewController, DispatchQueueViewController, TextureViewController, OperationQueueViewController
    var identifier: String {
        switch self {
        default: return self.rawValue
        }
    }
    var storyboardName: String {
        switch self {
        case .ProfileListViewController, .DetailViewController: return "ProfileList"
        case .EmailViewController: return "Auth"
        case .YouTubeViewController, .ViewController: return "Main"
        case .CreateClipsViewController: return "CreateClips"
        default: return "" //not support instantiate from storyboard
        }
    }
    public var nibName: String {
        switch self {
        default: return identifier
        }
    }
}

public extension RunLoop {
    /// This behaves like waitForExpectation, but gives us more control over performance
    @discardableResult
    func loopUntil(timeout: TimeInterval, pollingInterval: TimeInterval = 0.01, condition: () -> Bool) -> Bool {
        let endDate = Date(timeIntervalSinceNow: timeout)
        let punishTime:Double = 0.1
        var interval = pollingInterval
        while Date().compare(endDate) == .orderedAscending {
            if condition() {
                return true
            }
            if pollingInterval > 0 {
                run(until: Date(timeIntervalSinceNow: interval))
                interval += punishTime
                print("interval: \(interval), pollingInterval: \(pollingInterval), punishTime: \(punishTime), data: \(Date())")
            }
        }
        
        return false
    }
}






