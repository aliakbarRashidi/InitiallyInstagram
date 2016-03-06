//
//  LoginViewController.swift
//  InitiallyInstagram
//
//  Created by Anisha Gupta on 2/25/16.
//  Copyright © 2016 ani6gup. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signedUpLabel: UILabel!
    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet weak var usernameInvalidLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        passwordField.delegate = self
        self.signedUpLabel.hidden = true
        self.invalidLabel.hidden = true
        self.usernameInvalidLabel.hidden = true


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
    
        login()
    }
    
    
    

    @IBAction func onSignUp(sender: AnyObject) {
        
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Yay created a user")
                self.signedUpLabel.hidden = false
                
            } else {
                if(error?.code == 202)
                {
                    print("Username is taken")
                }
                
            }
        }
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

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            passwordField.resignFirstResponder()
            login()
        }
        return true
    }
    
}

private extension LoginViewController {
    func login()
    {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error:NSError?) -> Void in
            if user != nil {
                self.invalidLabel.hidden = true
                self.usernameInvalidLabel.hidden = true
                print("You're logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            else if(error?.code == 101)
            {
                self.invalidLabel.hidden = false
                 self.usernameInvalidLabel.hidden = true
            }
            else if(error?.code == 200)
            {
                self.usernameInvalidLabel.text = "Username is Required!"
                self.usernameInvalidLabel.hidden = false
            }
            else if(error?.code == 201)
            {
                self.usernameInvalidLabel.text = "Password is Required!"
                self.usernameInvalidLabel.hidden = false
            }
            
            
        }
        
    }
}
