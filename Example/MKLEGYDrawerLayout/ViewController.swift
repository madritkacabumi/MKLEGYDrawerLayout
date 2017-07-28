//
//  ViewController.swift
//  MKLEGYDrawerLayout
//
//  Created by devMadrit on 07/28/2017.
//  Copyright (c) 2017 devMadrit. All rights reserved.
//

import UIKit
import MKLEGYDrawerLayout
class ViewController: UIViewController {

    var sideMenu : DoubleSideMenu?
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle(identifier: "org.cocoapods.MKLEGYDrawerLayout");
        sideMenu = UIView.createView(attachTo: self.view, fromBundle: bundle)
        sideMenu?.setLeftMenuWidth(width: 150)
        sideMenu?.setMenuDimColor(colorHexString: "#5c5c5c")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

