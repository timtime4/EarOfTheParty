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
    var album : String!
    var artist : String!
    
    init(_title : String, _rank : String, _songID : String, _artist : String, _album : String){
        songTitle = _title
        rank = Int(_rank)!
        songID = _songID
        album = _album
        artist = _artist
    }
    
    func upVoteDict() -> AnyObject {
        rank = rank + 1
        return [
            "id": songID,
            "rank": String(rank),
            "songTitle": songTitle,
            "artist" : artist,
            "album" : album
        ]
    }
    
    func downVoteDict() -> AnyObject {
        rank = rank - 1
        return [
            "id": songID,
            "rank": String(rank),
            "songTitle": songTitle,
            "artist" : artist,
            "album" : album
        ]
    }
}
