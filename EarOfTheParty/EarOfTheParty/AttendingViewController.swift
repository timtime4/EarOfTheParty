//
//  AttendingViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/25/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit

class AttendingViewController: UIViewController {
    @IBOutlet weak var partiesAttendingTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
