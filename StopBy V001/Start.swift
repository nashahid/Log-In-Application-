//
//  ViewController.swift
//  StopBy V001
//
//  Created by Nabeel Shahid on 2015-08-24.
//  Copyright (c) 2015 Nabeel Shahid. All rights reserved.
//

import UIKit
import Parse

class Start: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func loginButton(sender: AnyObject) {
        var alert = UIAlertController(title: "Log-in Failed", message: "Please ensure you have entered the correct username/password", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        if((usernameField.text.isEmpty == false) && (passwordField.text.isEmpty == false)){
            var query = PFUser.query()
            query!.whereKey("username", equalTo: usernameField.text)
            var users = query!.countObjects()
            
            if (users == 0) {
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                performSegueWithIdentifier("second", sender: self)
            }
        }
        else {
            alert.message = "Please ensure that all filds are filled in"
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func signupButton(sender: AnyObject) {
        self.performSegueWithIdentifier("first", sender: self)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Object has been saved.")
        }
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

