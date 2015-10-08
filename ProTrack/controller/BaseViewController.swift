//
//  BaseViewController.swift
//  ProTrack
//
//  Created by Sunny on 10/10/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "btnlogout:")
        
    }
    func btnlogout(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true )
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
