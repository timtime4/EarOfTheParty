//
//  SongMetaData.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 5/2/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import Foundation

class SongMetaData {
    var songTitle : String!
    var rank : Int = 1
    
    init(_title : String, _rank : String){
        songTitle = _title
        rank = Int(_rank)!
    }
}
