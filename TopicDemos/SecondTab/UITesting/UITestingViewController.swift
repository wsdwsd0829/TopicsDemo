//
//  UITestingViewController.swift
//  TopicDemos
//
//  Created by Max Wang on 3/14/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class UITestingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var tgr:UITapGestureRecognizer!
    
    var animals = ["cat", "elephant", "snake", "mouse", "horse", "bull", "tiger", "rabbit", "dragon", "sheep", "monkey", "chicken", "dog", "pig"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = [];
         tgr = UITapGestureRecognizer(target: self, action: #selector(tappedInView(_:)))
        view.addGestureRecognizer(tgr)
        tgr.delegate = self
//!!!http://stackoverflow.com/questions/8192480/uitapgesturerecognizer-breaks-uitableview-didselectrowatindexpath
        tgr.cancelsTouchesInView = false  //will pass down to view from tableView and do not block tableView from receive it's own touch event to trigger didSelectRow
        
        let bbi = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editClicked))
        self.navigationItem.rightBarButtonItem = bbi

        print(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.allowsSelectionDuringEditing = true
        tableView.isUserInteractionEnabled = true
    }

 /*  //Not working
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == tgr {
            if type(of: touch.view) == UITableViewCell.self {
                return false
            }
        }
        return true
    }
  */
    func editClicked() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        label.text = textField.text ?? "???";
    }
    
    func tappedInView(_ sender: AnyObject) {
        textField.resignFirstResponder()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count;

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(tableView)

        var cell:UITableViewCell?
        let cellId = "UITestingCell"
        if let mycell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            cell = mycell
            cell?.textLabel?.text = "\(animals[indexPath.row])"
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            cell?.textLabel?.text = "\(animals[indexPath.row])"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            animals.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
//            tableView.reloadData() //this will stop tableView animating delete row

            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}








