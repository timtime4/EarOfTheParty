//
//  EOTPTabBarController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/26/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class EOTPTabBarController: UITabBarController {
    
    var user : User?
    var complete = false
    let ref = Firebase(url: "https://scorching-torch-7974.firebaseio.com/")


    override func viewDidLoad() {
        super.viewDidLoad()
        ref.observeAuthEventWithBlock { authData in
            if authData != nil {
                self.user = User(authData: authData)
                self.complete = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
