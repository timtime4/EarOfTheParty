//
//  Song.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/25/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import Foundation
import MediaPlayer

class Song {
    var item : MPMediaItem!
    var songTitle : String!
    var rank : Int = 1
    var songID : UInt64!   // Unique Song Identifier
    
    // Used for creating new parties and adding to Firebase
    init(_item : MPMediaItem){
        item = _item
        songTitle = _item.title
        songID = _item.persistentID
    }
    
    // Used for populating data from Firebase DB
    init(_songID: String){
        item = findSongWithPersistentIdString(_songID)
        if item != nil {
            songTitle = item.title
            songID = item.persistentID
        } else {
            print("couldn't find song")
        }
    }
    
    /* 
        copied from following link:
 http://stackoverflow.com/questions/34234867/finding-a-song-from-persistent-id-using-swift-2-programming
    */
    
    func findSongWithPersistentIdString(persistentIDString: String) -> MPMediaItem? {
        let predicate = MPMediaPropertyPredicate(value: persistentIDString, forProperty: MPMediaItemPropertyPersistentID)
        let songQuery = MPMediaQuery()
        songQuery.addFilterPredicate(predicate)
        
        var song: MPMediaItem?
        if let items = songQuery.items where items.count > 0 {
            song = items[0]
        }
        return song
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "songTitle": songTitle,
            "id": songID.description,
            "rank" : rank
        ]
    }
}