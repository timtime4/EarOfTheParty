//
//  PlayerViewController.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 5/2/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var songTitleLabel: UILabel!
    var player : MPMusicPlayerController?

    override func viewDidLoad() {
        super.viewDidLoad()
        let tbvc = self.tabBarController  as! EOTPTabBarController
        self.player = tbvc.player
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonPress(sender: AnyObject) {
        player?.pause()
    }
    
    @IBAction func nextButtonPress(sender: AnyObject) {
        player?.skipToNextItem()
        //player?.play()
    }
    
    @IBAction func playPress(sender: AnyObject) {
        player?.play()
    }

}
