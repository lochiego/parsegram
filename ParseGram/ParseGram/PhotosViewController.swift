//
//  PhotosViewController.swift
//  ParseGram
//
//  Created by Eric Gonzalez on 3/2/16.
//  Copyright © 2016 Eric Gonzalez. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func onLogout(sender: AnyObject) {
    NSNotificationCenter.defaultCenter().postNotificationName("logoutNotification", object: nil)
  }

}
