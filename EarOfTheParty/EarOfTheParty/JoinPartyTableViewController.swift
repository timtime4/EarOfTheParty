//
//  JoinPartyTableViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/25/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class JoinPartyTableViewController: UITableViewController {
    
    var searchCritia : String?
    var matchParties : [PartyMetaData] = []
    var selectedParty : PartyMetaData?

    let ref = Firebase(url: "https://scorching-torch-7974.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()
        partyQuery()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("matchedPartyCell",forIndexPath: indexPath)
        
        if !self.matchParties.isEmpty {
            cell.textLabel!.text = self.matchParties[indexPath.row].name
            cell.detailTextLabel!.text = "Hosted By: \(self.matchParties[indexPath.row].hostEmail!)"
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchParties.count
    }
    
    // Grab matching parties from Firebase
    func partyQuery() -> Void {
        let partyIndexRef = ref.childByAppendingPath("parties")
        partyIndexRef.observeEventType(.Value, withBlock: { snapshot in
            
            if let data = snapshot.value {
                let json = JSON(data)
                
                for(_, party) in json {
                    if party["name"].stringValue == self.searchCritia /* &&
                        party["hostID"] != self.user.uid */ {
                        let newParty = PartyMetaData(
                            _name : party["name"].stringValue,
                            _partyID : party["partyID"].stringValue,
                            _hostID : party["hostID"].stringValue,
                            _hostEmail : party["hostedByUser"].stringValue
                        )
                        self.matchParties.append(newParty)
                    }
    
                }
                self.tableView.reloadData()
            }
            
            }, withCancelBlock: { error in
                print(error.description)
                
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindToSearchParty" {
            if let cell = sender as? UITableViewCell,
                indexPath = self.tableView.indexPathForCell(cell) {
                self.selectedParty = self.matchParties[indexPath.row]
            } else {
                print("error")
            }
        }
    }

    
}
