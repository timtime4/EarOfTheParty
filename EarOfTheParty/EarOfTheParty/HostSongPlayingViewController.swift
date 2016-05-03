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
        

        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        /* Generate Array of MPMediaItems for collection */
        
        for song in (self.party?.playlist)! {
            mpMediaItemArr.append(song.item)
        }
        
        let collection = MPMediaItemCollection(items: mpMediaItemArr)
        print(collection.items)
        let player = MPMusicPlayerController()
        player.setQueueWithItemCollection(collection)
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
