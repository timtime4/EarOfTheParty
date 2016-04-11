//
//  LoginInViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/11/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import Firebase

class LoginInViewController: UIViewController {
    
    let ref = Firebase(url: "https://scorching-torch-7974.firebaseio.com/")
    let loginToHost = "loginToHost"

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 1
        ref.observeAuthEventWithBlock { (authData) -> Void in
            // 2
            if authData != nil {
                // 3
                self.performSegueWithIdentifier(self.loginToHost, sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerUser(sender: AnyObject) {
        let alert = UIAlertController(title: "Register",
            message: "Register",
            preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler {
            (textEmail) -> Void in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textPassword) -> Void in
            textPassword.secureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) {
            (handler: UIAlertAction!) -> Void in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            self.ref.createUser(emailField.text, password: passwordField.text) { (error: NSError!) in
                if error == nil {
                    self.ref.authUser(self.emailField.text, password: self.passwordField.text,
                        withCompletionBlock: { (error, auth) -> Void in
                    })
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }


    @IBAction func logIn(sender: AnyObject) {
        ref.authUser(emailField.text, password: passwordField.text,
            withCompletionBlock: { (error, auth) in
                
        })
        
    }
    

}
