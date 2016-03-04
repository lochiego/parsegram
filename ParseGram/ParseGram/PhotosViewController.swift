//
//  PhotosViewController.swift
//  ParseGram
//
//  Created by Eric Gonzalez on 3/2/16.
//  Copyright © 2016 Eric Gonzalez. All rights reserved.
//

import UIKit
import Parse

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PhotoSelectDelegate {
  
  var photos: [PFObject] = []
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 320
    fetchPhotos()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func fetchPhotos() {
    let query = PFQuery(className: "Post")
    query.orderByDescending("createdAt")
    //      query.includeKey("author")
    query.limit = 20
    
    // fetch data asynchronously
    query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
      if let posts = posts {
        self.photos = posts
        self.tableView.reloadData()
      } else {
        print("Failed to load images; \(error?.domain) - \(error?.code)")
      }
    }
  }
  
  @IBAction func onLogout(sender: AnyObject) {
    NSNotificationCenter.defaultCenter().postNotificationName("logoutNotification", object: nil)
  }
  
  // MARK: Table Data Source
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photos.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let photoCell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as! PhotoCell
    photoCell.photo = photos[indexPath.row]
    return photoCell
  }
  
  // MARK: Navigation Preparation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let nc = segue.destinationViewController as! UINavigationController
    let picker = nc.viewControllers.first as! PhotoSelectViewController
    picker.delegate = self
  }
  
  // MARK: Photo Select Delegate
  
  func photoSelectControllerFinishedSubmit() {
    self.dismissViewControllerAnimated(true, completion: nil)

    fetchPhotos()
  }
  
  func photoSelectControllerCanceledSelect() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
}
