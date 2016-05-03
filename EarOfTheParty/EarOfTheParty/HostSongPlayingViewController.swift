//
//  HostSongPlayingViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 5/2/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class HostSongPlayingViewController: UIViewController {
    
    var party : Party?
    var mpMediaItemArr : [MPMediaItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbvc = self.tabBarController  as! EOTPTabBarController
        
        /* Generate Array of MPMediaItems for collection */
        
        for song in (self.party?.playlist)! {
            mpMediaItemArr.append(song.item)
        }
        
        let collection = MPMediaItemCollection(items: mpMediaItemArr)
        print(collection.items)
        tbvc.player.setQueueWithItemCollection(collection)
        tbvc.player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
