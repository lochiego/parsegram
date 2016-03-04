//
//  PhotoSelectViewController.swift
//  ParseGram
//
//  Created by Eric Gonzalez on 3/4/16.
//  Copyright © 2016 Eric Gonzalez. All rights reserved.
//

import UIKit

protocol PhotoSelectDelegate: class {
  func photoSelectControllerFinishedSubmit()
  func photoSelectControllerCanceledSelect()
}

class PhotoSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  
  weak var delegate: PhotoSelectDelegate?
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var captionText: UITextField!
  @IBOutlet weak var distanceConstraint: NSLayoutConstraint!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

  @IBAction func onTakePicture(sender: AnyObject) {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    picker.sourceType = .PhotoLibrary
    self.presentViewController(picker, animated: true, completion: nil)
  }
  
  @IBAction func onCancel(sender: AnyObject) {
    delegate?.photoSelectControllerCanceledSelect()
  }
  
  @IBAction func onSubmit(sender: AnyObject) {
    Photos.postPhoto(imageView.image, caption: captionText.text) { (success, error) -> Void in
      if success {
        self.delegate?.photoSelectControllerFinishedSubmit()
      }
      else {
        let alert = UIAlertController(title: "Error", message: "Problem during submission, try again later\n\(error?.code)", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
      }
    }
  }
  
  // MARK: Image Picker Delegate
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    imageView.image = image
    view.addConstraint(distanceConstraint)
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }


}
