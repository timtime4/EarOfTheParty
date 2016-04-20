//
//  PartyViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/13/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit

class PartyViewController: UIViewController {
    
    var party : Party?
    
    @IBOutlet weak var songTableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.title = self.party?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(songTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = songTableView.dequeueReusableCellWithIdentifier("songCell",forIndexPath: indexPath)
        
        if  party?.playlist.count != 0 {
            cell.textLabel?.text = party?.playlist[indexPath.row].title
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.party?.playlist.count != 0 {
            return (self.party?.playlist.count)!
        } else {
            return 0
        }
    }
    
    // Unwind Action after Selecting song in HostAddSongController
    @IBAction func addNewSong(segue: UIStoryboardSegue){
        if let addNewSongVC = segue.sourceViewController as? HostAddSongViewController {
            self.party?.playlist.append(addNewSongVC.selectedSong!)
            self.songTableView.reloadData()
        }
    }


}
