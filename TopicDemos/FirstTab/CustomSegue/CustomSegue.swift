//
//  CustomSegue.swift
//  TopicDemos
//
//  Created by Sida Wang on 4/15/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        if let dest = destination as? TemplateViewController {
            dest.labelStr = "custom segue"
        }
    }
    
    override func perform() {
        self.source.navigationController?.pushViewController(destination, animated: true)
    }
}
