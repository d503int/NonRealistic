//
//  AppDelegate.swift
//  NPRHalftoning
//
//  Created by d503 on 3/18/16.
//  Copyright © 2016 d503. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    private var masterViewController: MasterViewController!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        
        window.contentView!.addSubview(masterViewController.view)
        masterViewController.view.frame = window.contentView!.bounds
        
        masterViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["subView" : masterViewController.view])
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["subView" : masterViewController.view])
        
        NSLayoutConstraint.activateConstraints(verticalConstraints + horizontalConstraints)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

