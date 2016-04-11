//
//  HostViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/11/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import Firebase

class HostViewController: UIViewController {
    
    let ref = Firebase(url: "https://scorching-torch-7974.firebaseio.com/")
    var user : User?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ref.observeAuthEventWithBlock { authData in
            if authData != nil {
                self.user = User(authData: authData)
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
