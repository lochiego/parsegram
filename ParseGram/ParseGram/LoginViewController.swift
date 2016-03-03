//
//  LoginViewController.swift
//  ParseGram
//
//  Created by Eric Gonzalez on 2/28/16.
//  Copyright © 2016 Eric Gonzalez. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
  
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var signUpButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "logout", name: "logoutNotification", object: nil)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onSignIn(sender: AnyObject) {
  enableUI(false)
    PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user, error) -> Void in
      if user != nil {
        print("you're logged in")
        self.performSegueWithIdentifier("loginSegue", sender: self)
        self.passwordField.text = nil
      } else {
        
      }
      self.enableUI(true)
    }
    
  }
  
  @IBAction func onSignUp(sender: AnyObject) {
    let newUser = PFUser()
    
    newUser.username = usernameField.text
    newUser.password = passwordField.text
    
    enableUI(false)
    newUser.signUpInBackgroundWithBlock { (success, error) -> Void in
      if success {
        print("Yay, created a user!")
        self.performSegueWithIdentifier("loginSegue", sender: self)
      } else {
        print(error?.localizedDescription)
        if error?.code == 202 {
          print("Username is taken")
        }
      }
      self.enableUI(true)
    }
  }
  
  func logout() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func enableUI(enable: Bool) {
    signInButton.enabled = enable
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
