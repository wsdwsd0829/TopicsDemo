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
    var count: Int = 0
    var timer: Timer!
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
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
//        wait()
        testConditionalBreakPoint()

    }
    
    // will blocking current thread, and time deferred correctly on main thread
    // in uncomment global Queue, run loop will run creazy, until we add mytimer for it.
    func wait() {
        DispatchQueue.global().async {
            let mytimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.backgroundTimerFired), userInfo: nil, repeats: true)
            RunLoop.current.add(mytimer, forMode: .commonModes)
            RunLoop.current.loopUntil(timeout: 20, pollingInterval: 0.5, condition: { () -> Bool in
                self.label.text == "10"
            })
            print("found 5")
        }
    }
    
    //MARK conditional break point
    //http://jeffreysambells.com/2014/01/14/using-breakpoints-in-xcode
    //http://www.fantageek.com/2016/01/15/symbolic-breakpoints-in-xcode/
    //e.g. condition: ((i >= 5) && (condition == true))
    //e.g. symbolic break point: UITestingViewController.updateLabel
    func testConditionalBreakPoint() {
        let condition = true
        // you place these breakpoints in the user breakpoint (right click and select “Move Breakpoint To > User”) so that they are shared across all your projects.
        for i in 1...14 {
            //print(i)
        }
        testExceptionBreakPoint()
    }
    
    func testExceptionBreakPoint()  {
        enum CustomError: Error {
            case error1
        }
        do {
            throw CustomError.error1
        } catch CustomError.error1 {
            print("catch 1")  //will print
        } catch {
            print("catch 2")
        }
    }
    
    func updateLabel() {
        label.text = "\(count)"
        label.accessibilityIdentifier = "id" + label.text!
        count += 1
    }
    func backgroundTimerFired() {
        print("backgroundTimerFired")
    }

    func editClicked() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        label.text = textField.text ?? "???";
        timer.invalidate()
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








