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
    
    let ref = Firebase(url: "https://scorching-torch-7974.firebaseio.com/")
    var party : PartyMetaData?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "songCell")
        if self.party?.didInitialFBQuery == false { getPlaylist() }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(songTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> SongTableViewCell {
        
        let cell = songTableView.dequeueReusableCellWithIdentifier("songCell",forIndexPath: indexPath) as! SongTableViewCell
        cell.deleteButton.hidden = true // attendees cannot delete songs
        
        // Add triggers for UpVote and DownVote Buttons
        cell.upVoteButton.tag = indexPath.row
        cell.upVoteButton.addTarget(self, action: #selector(AttendingPlaylistTableViewController.upVote(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.downVoteButton.tag = indexPath.row
        cell.downVoteButton.addTarget(self, action: #selector(AttendingPlaylistTableViewController.downVote(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        if  party?.playlist.count != 0 {
            cell.songTitleLabel?.text = party?.playlist[indexPath.row].songTitle
            cell.albumLabel?.text = party?.playlist[indexPath.row].songTitle
            cell.artistLabel?.text = party?.playlist[indexPath.row].songTitle
            cell.rankLabel?.text = String(party!.playlist[indexPath.row].rank)
        }
        
        return cell
        
    }
    
    // Remove ability to select cells
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("songCell",forIndexPath: indexPath) as! SongTableViewCell
        
        cell.deleteButton.hidden = true // attendees cannot delete songs
        
        cell.selected = false
        
        // Add triggers for UpVote and DownVote Buttons
        cell.upVoteButton.tag = indexPath.row
        cell.upVoteButton.addTarget(self, action: #selector(AttendingPlaylistTableViewController.upVote(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.downVoteButton.tag = indexPath.row
        cell.downVoteButton.addTarget(self, action: #selector(AttendingPlaylistTableViewController.downVote(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        if  party?.playlist.count != 0 {
            cell.songTitleLabel?.text = party?.playlist[indexPath.row].songTitle
            cell.albumLabel?.text = party?.playlist[indexPath.row].songTitle
            cell.artistLabel?.text = party?.playlist[indexPath.row].songTitle
            cell.rankLabel?.text = String(party!.playlist[indexPath.row].rank)
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.party?.playlist.count != 0 {
            return (self.party?.playlist.count)!
        } else {
            return 0
        }
    }
    
    func downVote(sender:UIButton) -> Void {
        print("down vote pressed")
        let buttonRow = sender.tag
        
        // Decrease Rank on song
        let songRef = self.ref.childByAppendingPath("users/\(self.party!.hostID)/partiesHosting/\(self.party!.partyID)/songs/\(self.party!.playlist[buttonRow].songID)")
        songRef.setValue(self.party!.playlist[buttonRow].downVoteDict())
        
        self.party?.playlist.sortInPlace({ $0.rank > $1.rank })
        
        self.tableView.reloadData()
    }
    
    func upVote(sender:UIButton) -> Void {
        print("up vote pressed")
        let buttonRow = sender.tag
        
        // Decrease Rank on song
        let songRef = self.ref.childByAppendingPath("users/\(self.party!.hostID)/partiesHosting/\(self.party!.partyID)/songs/\(self.party!.playlist[buttonRow].songID)")
        songRef.setValue(self.party!.playlist[buttonRow].upVoteDict())
        
        self.party?.playlist.sortInPlace({ $0.rank > $1.rank })
        
        self.tableView.reloadData()
    }

    
    // Grab playlist from Firebase
    func getPlaylist() -> Void {
        
        let path = "https://scorching-torch-7974.firebaseio.com/users/\(self.party!.hostID)"
        let partiesRef = Firebase(url: path)
        
        partiesRef.queryOrderedByChild("partiesHosting").observeEventType(.ChildAdded, withBlock: { snapshot in
            print("getPlaylist()")
            
            if let data = snapshot.value.objectForKey(self.party!.partyID) {
                let json = JSON(data)
                
                for(_, song) in json["songs"] {
                    let newSong = SongMetaData(_title: song["songTitle"].stringValue,
                        _rank: song["rank"].stringValue, _songID : song["id"].stringValue)
                    self.party!.playlist.append(newSong)
                }
                self.party?.didInitialFBQuery = true
                self.party?.playlist.sortInPlace({ $0.rank > $1.rank }) // sort by rank
                self.tableView.reloadData()
            }
            
            }, withCancelBlock: { error in
                print(error.description)
                
        })
    }

   
}
