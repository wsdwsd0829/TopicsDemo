//
//  NavigationViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 4/11/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import Foundation

/*
 TODO:
 beyond basics: animate navigationBar hidden style?
 delegation 
 */

class NavigationViewController: UIViewController, UIToolbarDelegate {
    @IBOutlet weak var presentNVC: UIButton!
    @IBOutlet weak var presentVCInNVC: UIButton!

    @IBOutlet weak var pushNVC: UIButton!
    @IBOutlet weak var pushVC: UIButton!
    
    var tvcInNVC: TemplateViewController!
    var nvc: UINavigationController!
    var tvc: TemplateViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //either works, whoever comes after wins 
        //works in viewWill/DidAppear
        title = "abcdefg"
        navigationItem.title = "block you"
        
        
        //MARK navigationBar appearance:
        navigationController?.navigationBar.tintColor = UIColor.blue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false //default true
        
        //hidden nav bar
        //TODO: gesture to toggle
        let gr = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(gr)
        
        //MARK: navigation (bar) hidden
        //must be called after viewDidLoad
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //MARK: tool bar & items  
        //step 1. set hidden in viewWillAppear/Disappear, step2 set toolbar items
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let mid = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
        let left = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
        let right = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
        //!!! flex can reuse but others cannot
        toolbarItems = [flex, left, flex,mid,flex, right, flex]
        //1. set frame not working!
        //2. navigationController?.toolbar.delegate = self; //not working!
        //'Cannot manually set the delegate on a UIToolbar managed by a controller.'
         //TODO: create custome bar to adjust position
        
        
        //push & present
        tvcInNVC = TemplateViewController.getOne()
        tvc = TemplateViewController.getOne()
        nvc = UINavigationController(rootViewController: tvcInNVC!)
        
        presentNVC.addTarget(self, action: #selector(presentNVC_Clicked(_:)), for: .touchUpInside)
        presentVCInNVC.addTarget(self, action: #selector(presentVCInNVC_Clicked(_:)), for: .touchUpInside)
        
        pushNVC.addTarget(self, action: #selector(pushNVC_Clicked(_:)), for: .touchUpInside)
        pushVC.addTarget(self, action: #selector(pushVCInNVC_Clicked(_:)), for: .touchUpInside)
    }
    func viewTapped(_ sender: UITapGestureRecognizer!) {
        self.navigationController?.setNavigationBarHidden(!(self.navigationController?.isNavigationBarHidden)!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
        //reverse style
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = true //default true

    }
    
    //MARK: present/push trickes
    
    //case 1
    //works, a new presend NVC
    func presentNVC_Clicked(_ sender: AnyObject!) {
        present(nvc!, animated: true, completion: {
            self.tvcInNVC.label.text = "created from navigation view controller"
        })
    }
    
    //case 2
    //crash!!!
    //'Application tried to present modally an active controller 
    //<TopicDemos.NavigationViewController: 0x7f9ce54427b0>.'
    func presentVCInNVC_Clicked(_ sender: AnyObject!) {
        present(tvcInNVC, animated: true, completion: nil)
        
        //but this works!!!
        //show(tvcInNVC, sender: self) // cannot present, so it choose push (with side effect: if cancel and then call present(nvc!...) will show black screen, because nvc's child is poped)
        //how about in cancel detect how many childViewControllers? (if 1 do not dismiss) -> nope: because nvc1->vc1->nvc2->vc2
        // vc2.navigationController will return return nvc1
    }
    
    //case 3
    //assuming we have an nvc aleady:
    //'Pushing a navigation controller is not supported'
    func pushNVC_Clicked(_ sender: AnyObject!) {
        self.navigationController?.pushViewController(nvc, animated: true)
        
        //but this works!!!
        //self.navigationController?.show(nvc, sender: self) //cannot push so try to present
    }
    
    //case 4
    //work but:do not do this also has side effect as case 2's show
    func pushVCInNVC_Clicked(_ sender: AnyObject!) {
        assert(self.navigationController !== tvcInNVC.navigationController)
        self.navigationController?.pushViewController(tvcInNVC, animated: true)
        assert(self.navigationController === tvcInNVC.navigationController)
//        tvc.toolbarItems = toolbarItems  (need to reset if add new controller)
//        self.navigationController?.pushViewController(tvc, animated: true)

    }
    
    //easy to understand, not in buttons
    func pushVC_Clicked(_ sender: AnyObject) {
        self.navigationController?.pushViewController(tvc, animated: true)
    }
    
}

//take away:  1. alway present or push single controller, with only exception: present modally navigation controller with rootViewController
//2. do not use show(xxx) if do not know what you are doing, at least I do not yet;

//only 
//1. present nvc 
//2. push/present vc without nvc





