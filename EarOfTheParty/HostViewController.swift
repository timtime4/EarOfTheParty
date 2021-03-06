//
//  HostViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/11/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import AVKit


class HostViewController: UIViewController {
    
    @IBOutlet weak var partiesTableView: UITableView!
    
    let ref = Firebase(url: "https://scorching-torch-7974.firebaseio.com/")
    var user : User?
    var newParty : Party?

    override func viewDidLoad() {
        super.viewDidLoad()
        var tbvc = self.tabBarController  as! EOTPTabBarController
        dispatch_async(dispatch_get_main_queue(), {
            // Keep reassigning tbvc until user has been authenticated
            while tbvc.complete == false { tbvc = self.tabBarController  as! EOTPTabBarController }
            self.user = tbvc.user
            self.getPartiesHosting()
        })

        self.partiesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.partiesTableView.reloadData()
    }
    
    func tableView(partiesTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = partiesTableView.dequeueReusableCellWithIdentifier("partyCell",forIndexPath: indexPath)
        
        if self.user?.partiesHosting.count != 0 {
            cell.textLabel?.text = self.user?.partiesHosting[indexPath.row].name
        }
        
        return cell
            
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.user != nil {
            return (self.user?.partiesHosting.count)!
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
            self.user?.partiesHosting.append(self.newParty!)
            
            // Create Party on Firebase DB
            let partyRef = self.ref.childByAppendingPath("users/\(self.user!.uid)/partiesHosting/\(self.newParty!.partyID)")
            let partyIndex = self.ref.childByAppendingPath("parties/\(self.newParty!.partyID)")
            partyRef.setValue(self.newParty!.toAnyObject())
            partyIndex.setValue(self.newParty!.toPartyIndexObject())
            
            self.performSegueWithIdentifier("partiesToPartyInfo", sender: nil)

        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action: UIAlertAction) -> Void in
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
                    partyInfoVC.party = self.user?.partiesHosting[indexPath.row]
            } else {
            
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
    
    func getPartiesHosting() -> Void {
        ref.queryOrderedByChild("users").observeEventType(.ChildAdded, withBlock: { snapshot in
            print("getPartiesHosting()")
            if self.user != nil {
                if let data = snapshot.value.objectForKey(self.user!.uid) {
                    let json = JSON(data)
                    
                    for(_, party) in json["partiesHosting"] {
                        let name = party["name"].stringValue
                        let id = party["id"].stringValue
                        
                        let newParty = Party(_name: name, _host: self.user!, _partyID: id)
                        self.user?.partiesHosting.append(newParty)
                    }
                    self.partiesTableView.reloadData()
                }
            } else {
                print("user not assigned yet")
            }
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    
    
    
    


}
