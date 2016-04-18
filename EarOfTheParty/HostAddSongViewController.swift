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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.songItems!.count != 0 {
            return self.songItems!.count
        } else {
            return 0
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
