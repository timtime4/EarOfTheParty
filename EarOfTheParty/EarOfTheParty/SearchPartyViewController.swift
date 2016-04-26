//
//  JoinPartyViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/25/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit

class SearchPartyViewController: UIViewController {

    @IBOutlet weak var partyNameTextField: UITextField!
    override func viewDidLoad() {

        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toJoinParty" {
            
            // Executes if sent by selecting existing party
            if let joinPartyVC = segue.destinationViewController as? JoinPartyTableViewController {
                joinPartyVC.searchCritia = self.partyNameTextField.text
            }
            
        }
    }
    
    

}
