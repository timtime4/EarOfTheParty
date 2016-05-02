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
    var songID : String!
    
    init(_title : String, _rank : String, _songID : String){
        songTitle = _title
        rank = Int(_rank)!
        songID = _songID
    }
    
    func upVoteDict() -> AnyObject {
        rank = rank + 1
        return [
            "id": songID,
            "rank": String(rank),
            "songTitle": songTitle
        ]
    }
    
    func downVoteDict() -> AnyObject {
        rank = rank - 1
        return [
            "id": songID,
            "rank": String(rank),
            "songTitle": songTitle
        ]
    }
}
