//
//  UITestingViewController.swift
//  TopicDemos
//
//  Created by Max Wang on 3/14/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

class UITestingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = [];
        let tgr = UITapGestureRecognizer(target: self, action: #selector(tappedInView(_:)))
        view.addGestureRecognizer(tgr)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        label.text = textField.text ?? "???";
    }
    
    func tappedInView(_ sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        let cellId = "UITestingCell"
        if let mycell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            cell = mycell
            cell?.textLabel?.text = "Cell row index: \(indexPath.row)"
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            cell?.textLabel?.text = "Cell row index: \(indexPath.row)"

        }
        return cell!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
