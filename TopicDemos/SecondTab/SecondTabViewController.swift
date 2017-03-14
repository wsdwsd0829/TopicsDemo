//
//  SecondTabViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 3/12/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class SecondTabViewController: UITableViewController {
    struct Constants {
        static let cellIdentifier: String = "DefaultCellIdentifer";
    }
    enum Row: Int {
        case promiseKit, uiTesting
        var title:String {
            switch self {
            case .promiseKit: return "PromiseKit";
            case .uiTesting: return "UITesting"
            }
        }
        var identifier: String {
            switch self {
            case .promiseKit: return "PromiseKitViewController"
            case .uiTesting: return "UITestingViewController"
            }
        }
        
        var nibName: String? {
            return Controllers(rawValue: identifier)?.nibName
        }
        var viewControllerType: UIViewController.Type {  //UIViewController.Type is AnyClass
            switch self {
            case .promiseKit: return PromiseKitViewController.self
            case .uiTesting: return UITestingViewController.self
            }
            
        }
        
        static func row(at indexPath: IndexPath) -> Row? {
            return Row(rawValue: indexPath.row)
        }
        
        static var allRows: [Row] {
            return [.promiseKit, .uiTesting]
        }
        /*
        var viewController: AnyClass {
            switch self {
            case .promiseKit: return PromiseKitViewController.self
            case .uiTesting: return UITestingViewController.self
            }
        }
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        
        //MARK: hide separator
        //http://stackoverflow.com/questions/8561774/hide-separator-line-on-one-uitableviewcell
        self.tableView.separatorColor = UIColor.clear;
    }

    //MARK: TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.allRows.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: Constants.cellIdentifier)
        }
        config(cell:cell!, for: indexPath)
        return cell!
    }
    
    func config(cell: UITableViewCell, for indexPath: IndexPath) {
        if let title = Row.row(at: indexPath)?.title,
            let font = UIFont(name: "HelveticaNeue", size: 18){
            cell.textLabel?.attributedText = NSAttributedString(string: title, attributes: [NSFontAttributeName: font])
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vcType = (Row.row(at: indexPath)?.viewControllerType) {
            let pkvc = UIViewController.instantiate(controllerType: vcType, .nib)
            self.navigationController?.pushViewController(pkvc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
}

















