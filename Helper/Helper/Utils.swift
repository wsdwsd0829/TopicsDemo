//
//  Utils.swift
//  Helper
//
//  Created by Max Wang on 6/27/17.
//  Copyright © 2017 Max Wang. All rights reserved.
//

import Foundation

public class Utils {
    public static func showAlert(from vc: UIViewController,
                          title: String = "Sample Title",
                          message: String = "Sample Msg") {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(okAction)
        vc.present(alertVC, animated: true, completion: nil)
    }
}

public func delay(_ seconds: Int, closure: @escaping ()->()) {
    let time = DispatchTime.now() + .seconds(seconds)
    DispatchQueue.main.asyncAfter(deadline: time) {
        print("🕑")
        closure()
    }
}
