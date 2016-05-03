//
//  PartyViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/13/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class PartyViewController: UIViewController {
    
    var party : Party?
    let ref = Firebase(url: "https://scorching-torch-7974.firebaseio.com/")
    
    @IBOutlet weak var songTableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.title = self.party?.name
        self.songTableView.registerNib(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "songCell")

        if self.party?.didInitialFBQuery == false { getPlaylist() }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {

    }

    
    func tableView(songTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = songTableView.dequeueReusableCellWithIdentifier("songCell",forIndexPath: indexPath) as! SongTableViewCell
        
        if  party?.playlist.count != 0 {
            cell.songTitleLabel?.text = party?.playlist[indexPath.row].item.title
            cell.albumLabel?.text = party?.playlist[indexPath.row].item.albumTitle
            cell.artistLabel?.text = party?.playlist[indexPath.row].item.artist
            cell.rankLabel?.text = String(party!.playlist[indexPath.row].rank)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("cell selected")
        self.performSegueWithIdentifier("toHostSongPlaying", sender: nil)
    }
    
    // Unwind Action after Selecting song in HostAddSongController
    @IBAction func addNewSong(segue: UIStoryboardSegue){
        if let addNewSongVC = segue.sourceViewController as? HostAddSongViewController {
            let newSong = addNewSongVC.selectedSong!
            self.party?.playlist.append(newSong)
            
            // Add song to party Firebase DB
            let songRef = self.ref.childByAppendingPath("users/\(self.party!.host.uid)/partiesHosting/\(self.party!.partyID)/songs/\(newSong.songID)")
            songRef.setValue(newSong.toAnyObject())
            
            self.songTableView.reloadData()
        }
    }
    
    
    // Grab playlist from Firebase
    func getPlaylist() -> Void {
        let path = "https://scorching-torch-7974.firebaseio.com/users/\(self.party!.host.uid)"
        let partiesRef = Firebase(url: path)
        
        partiesRef.queryOrderedByChild("partiesHosting").observeEventType(.ChildAdded, withBlock: { snapshot in
            print("getPlaylist()")
            
            if let data = snapshot.value.objectForKey(self.party!.partyID) {
                let json = JSON(data)
                
                for(_, song) in json["songs"] {
                    let newSong = Song(_songID: song["id"].stringValue, _rank : song["rank"].stringValue)
                    self.addObservers(newSong)
                    self.party?.playlist.append(newSong)
                }
                self.party?.didInitialFBQuery = true
                self.party?.playlist.sortInPlace({ $0.rank > $1.rank }) // sort by rank
                self.songTableView.reloadData()
            }
            
            }, withCancelBlock: { error in
                print(error.description)
                
        })
    }

    
    func addObservers(song : Song){
        // Get a reference to each song
        let path = "users/\(self.party!.host!.uid)/partiesHosting/\(self.party!.partyID)/songs/\(song.songID)"
        let playlistRef = self.ref.childByAppendingPath(path)
        
        // Get the data on a post that has changed
        playlistRef.observeEventType(.ChildChanged, withBlock: { snapshot in
            let newRank = snapshot.value as? String
            song.rank = Int(newRank!)!
            self.party?.playlist.sortInPlace({ $0.rank > $1.rank }) // sort playlist by song rank
            self.songTableView.reloadData()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toHostSongPlaying" {
            if let songPlayingVC = segue.destinationViewController as? HostSongPlayingViewController {
                songPlayingVC.party = self.party
            }
            
        }
    }

}


