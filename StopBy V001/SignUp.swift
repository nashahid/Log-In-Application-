//
//  SignUPvc.swift
//  StopBy3
//
//  Created by Nabeel Shahid on 2015-08-04.
//  Copyright (c) 2015 Nabeel Shahid. All rights reserved.
//

import Parse
import UIKit

class SignUp: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameField: UITextField! = nil
    
    @IBOutlet weak var passwordFieldOne: UITextField! = nil
    
    @IBOutlet weak var passwordFieldTwo: UITextField! = nil
    
    @IBOutlet weak var clearLabel: UILabel! = nil
    
    @IBOutlet weak var pwordClearLabel: UILabel!
    
    var pwordsClear = false;
    var usernameClear = false;

    
    func textFieldDidEndEditing(textField: UITextField)
    {
        if(usernameField.text.isEmpty == false){
            var query = PFUser.query()
            query!.whereKey("username", equalTo: usernameField.text)
            var users = query!.countObjects()
            
            if (users == 0) {
                clearLabel.text = "Username is available"
                clearLabel.textColor = UIColor.blackColor()
                usernameClear = true;
            }
            else {
                clearLabel.text = "Username already taken"
                clearLabel.textColor = UIColor.redColor()
                usernameClear = false;
            }
        }
        else {
            clearLabel.text = ""
        }
        
        if (passwordFieldOne.text.isEmpty == false) && (passwordFieldTwo.text.isEmpty == false){
            if (passwordFieldOne.text == passwordFieldTwo.text) {
                pwordClearLabel.text = "Passwords match"
                pwordClearLabel.textColor = UIColor.blackColor()
                pwordsClear = true;
            }
            else{
                pwordClearLabel.text = "Passwords do not match"
                pwordClearLabel.textColor = UIColor.redColor()
                pwordsClear = false;
            }
        }
        else {
            pwordClearLabel.text = ""
        }
    }

    
    @IBAction func signupButton(sender: AnyObject)
    {
        var alert = UIAlertController(title: nil, message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))

        if (pwordsClear == true) && (usernameClear == true){
            var user = PFUser()
            user.username = usernameField.text
            user.password = passwordFieldTwo.text
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> () in
                if let inerror = error {
                    let errorString = inerror.userInfo?["error"] as? NSString
                    alert.title = "Sign-up Failed"
                    alert.message = "Please re-enter your information and try again"
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else {
                    alert.title = "Sign-up Succesful"
                    alert.message = "Your account is now active"
                    self.presentViewController(alert, animated: true, completion: nil)
                    self.usernameField.text = ""
                    self.passwordFieldOne.text = ""
                    self.passwordFieldTwo.text = ""
                    self.pwordClearLabel.text = ""
                    self.clearLabel.text = ""
                    //alert.prepareForSegue(<#segue: UIStoryboardSegue#>, sender: <#AnyObject?#>)
                }
            }
        }
        else {
            alert.title = "Sign-up Failed"
            alert.message = "Please enter a valid username and password combination"
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        performSegueWithIdentifier("third", sender: self)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        usernameField.resignFirstResponder()
        passwordFieldOne.resignFirstResponder()
        passwordFieldTwo.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        usernameField.delegate = self
        passwordFieldOne.delegate = self
        passwordFieldTwo.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

