//
//  AttendingViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/25/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class AttendingViewController: UIViewController {
    @IBOutlet weak var partiesAttendingTableView: UITableView!
    
    var user : User?
    let ref = Firebase(url: "https://scorching-torch-7974.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()
        var tbvc = self.tabBarController  as! EOTPTabBarController
        dispatch_async(dispatch_get_main_queue(), {
            // Keep reassigning tbvc until user has been authenticated
            while tbvc.complete == false { tbvc = self.tabBarController  as! EOTPTabBarController }
            self.user = tbvc.user
            self.getPartiesAttending()
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(partiesTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = partiesTableView.dequeueReusableCellWithIdentifier("partyAttendingCell",forIndexPath: indexPath)
        
        if self.user?.partiesAttending.count != 0 {
            cell.textLabel?.text = self.user?.partiesAttending[indexPath.row]["name"]
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.user != nil {
            return (self.user?.partiesAttending.count)!
        } else {
            return 0
        }
    }
    
    // Unwind action after selecting party in Join Party Table View Controller
    @IBAction func joinSelectedParty(segue: UIStoryboardSegue){
        if let joinPartyVC = segue.sourceViewController as? JoinPartyTableViewController {
            let selectedPartyMetaData = joinPartyVC.selectedParty!
            print(selectedPartyMetaData)
            self.user?.partiesAttending.append(selectedPartyMetaData)
            
            // Add party to party Firebase DB
            let path = "users/\(self.user!.uid)/partiesAttending/\(selectedPartyMetaData["partyID"]!)"
            let partyRef = self.ref.childByAppendingPath(path)
            partyRef.setValue(selectedPartyMetaData)
             
            self.partiesAttendingTableView.reloadData()
        }
        
    }
    
    func getPartiesAttending() -> Void {
        ref.queryOrderedByChild("users").observeEventType(.ChildAdded, withBlock: { snapshot in
            print("getPartiesAttending()")
            if self.user != nil {
                if let data = snapshot.value.objectForKey(self.user!.uid) {
                    let json = JSON(data)
                    
                    for(_, party) in json["partiesAttending"] {
                        let partyMetaData = [
                            "name" : party["name"].stringValue,
                            "hostID" : party["hostID"].stringValue,
                            "partyID" : party["partyID"].stringValue,
                            "hostEmail" : party["hostEmail"].stringValue
                        ]
                        self.user?.partiesAttending.append(partyMetaData)
                    }
                    self.partiesAttendingTableView.reloadData()
                }
            } else {
                print("user not assigned yet")
            }
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }


}
