//
//  EOTPTabBarController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/26/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import AVFoundation
import MediaPlayer

class EOTPTabBarController: UITabBarController {
    
    var user : User?
    var complete = false
    let ref = Firebase(url: "https://scorching-torch-7974.firebaseio.com/")
    let player = MPMusicPlayerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        ref.observeAuthEventWithBlock { authData in
            if authData != nil {
                self.user = User(authData: authData)
                self.complete = true
            }
        }
        
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
        
        player.beginGeneratingPlaybackNotifications()
        player.repeatMode = MPMusicRepeatMode.None
        
        clearCollection()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func clearCollection() {
        let emptyArr : [MPMediaItem] = []
        let collection = MPMediaItemCollection(items: emptyArr)
        self.player.setQueueWithItemCollection(collection)
        self.player.nowPlayingItem = nil
    }
    

}
