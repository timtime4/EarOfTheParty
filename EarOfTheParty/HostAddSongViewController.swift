//
//  HostAddSongViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/13/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import MediaPlayer

class HostAddSongViewController: UIViewController {
    
    var songItems : [MPMediaItem]?
    var selectedSong : Song?

    @IBOutlet weak var songTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.songItems = MPMediaQuery.songsQuery().items

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(songTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = songTableView.dequeueReusableCellWithIdentifier("songCell",forIndexPath: indexPath)
        
        if  songItems?.count != 0 {
            cell.textLabel?.text = songItems![indexPath.row].title as String!
            
        }
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindToPartyView" {
            if let cell = sender as? UITableViewCell,
                indexPath = self.songTableView.indexPathForCell(cell) {
                self.selectedSong = Song(_item: songItems![indexPath.row])
            } else {
                print("error")
            }
        }
    }
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.songItems!.count != 0 {
            return self.songItems!.count
        } else {
            return 0
        }
        
    }

    


}
