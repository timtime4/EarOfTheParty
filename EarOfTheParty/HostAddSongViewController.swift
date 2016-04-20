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
    var selectedSong : MPMediaItem?

    @IBOutlet weak var songTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.songItems = MPMediaQuery.songsQuery().items
        print(songItems)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(songTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("Loading Cell")
        let cell = songTableView.dequeueReusableCellWithIdentifier("songCell",forIndexPath: indexPath)
        
        if  songItems?.count != 0 {
            cell.textLabel?.text = songItems![indexPath.row].title as String!
        }
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindToPartyView" {
            print("Unwinding to Party View, cell selected")
            if let cell = sender as? UITableViewCell,
                indexPath = self.songTableView.indexPathForCell(cell) {
                print("Adding \(songItems![indexPath.row])")
                self.selectedSong = songItems![indexPath.row]
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
