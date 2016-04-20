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
    
    @IBOutlet weak var partiesTableView: UITableView!
    
    let ref = Firebase(url: "https://scorching-torch-7974.firebaseio.com/")
    var user : User?
    var newParty : Party?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observeAuthEventWithBlock { authData in
            if authData != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    self.user = User(authData: authData)
                    print("1")
                    print(self.user?.email)
                    
                    self.user?.parties.append(Party(_name: "Test Party", _host: self.user!))
                    
                    print(self.user?.parties[0].name)
                    self.partiesTableView.reloadData()
                })
                
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
    func tableView(partiesTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("Loading Cell")
        let cell = partiesTableView.dequeueReusableCellWithIdentifier("partyCell",forIndexPath: indexPath)
        
        if self.user != nil {
            cell.textLabel?.text = self.user?.parties[indexPath.row].name
        }
        
        return cell
            
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count=\(self.user?.parties.count)?")
        
        if self.user != nil {
            return (self.user?.parties.count)!
        } else {
            return 0
        }
        
    }
    
    @IBAction func createNewParty(sender: AnyObject) {
        // Alert View for input
        let alert = UIAlertController(title: "New Party",
                                      message: "Name Your Party",
                                      preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) {
            (action: UIAlertAction) -> Void in
                                        
            let textField = alert.textFields![0]
            self.newParty = Party(_name: textField.text!, _host: self.user!)
            self.user?.parties.append(self.newParty!)
            // Create Party on Firebase DB
            let partyRef = self.ref.childByAppendingPath("parties")
            
            partyRef.setValue(self.newParty!.toAnyObject())
            self.performSegueWithIdentifier("partiesToPartyInfo", sender: nil)

        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "partiesToPartyInfo" {
            
            // Executes if sent by selecting existing party
            if let partyInfoVC = segue.destinationViewController as? PartyViewController,
                cell = sender as? UITableViewCell,
                indexPath = self.partiesTableView.indexPathForCell(cell) {
                    partyInfoVC.party = self.user?.parties[indexPath.row]
            }
            
            // Executes if sent by tapping "New Party" button
            if let partyInfoVC = segue.destinationViewController as? PartyViewController {
                print("From 'new party' button")
                if self.newParty != nil {
                    partyInfoVC.party = self.newParty
                }
            }
        }
    }
    


}
