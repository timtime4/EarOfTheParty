//
//  AttendingPlaylistTableViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/27/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class AttendingPlaylistTableViewController: UITableViewController {
    
    var party : PartyMetaData?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "songCell")


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        getPlaylist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(songTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> SongTableViewCell {
        
        let cell = songTableView.dequeueReusableCellWithIdentifier("songCell",forIndexPath: indexPath) as! SongTableViewCell
        
        if  party?.playlist.count != 0 {
            cell.songTitleLabel?.text = party?.playlist[indexPath.row].songTitle
            cell.albumLabel?.text = party?.playlist[indexPath.row].songTitle
            cell.artistLabel?.text = party?.playlist[indexPath.row].songTitle
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.party?.playlist.count != 0 {
            return (self.party?.playlist.count)!
        } else {
            return 0
        }
    }


    
    // Grab playlist from Firebase
    func getPlaylist() -> Void {
        
        let path = "https://scorching-torch-7974.firebaseio.com/users/\(self.party!.hostID)"
        let partiesRef = Firebase(url: path)
        
        partiesRef.queryOrderedByChild("partiesHosting").observeEventType(.ChildAdded, withBlock: { snapshot in
            print("getPlaylist()")
            
            if let data = snapshot.value.objectForKey(self.party!.partyID) {
                let json = JSON(data)
                print(json)
                
                for(_, song) in json["songs"] {
                    let newSong = SongMetaData(_title: song["songTitle"].stringValue,
                        _rank: song["rank"].stringValue)
                    self.party!.playlist.append(newSong)
                }
                self.party?.didInitialFBQuery = true
                print(self.party?.playlist)
                self.tableView.reloadData()
            }
            
            }, withCancelBlock: { error in
                print(error.description)
                
        })
    }

   
}
