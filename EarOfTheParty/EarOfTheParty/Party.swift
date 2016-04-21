//
//  Party.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/13/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import Foundation
import MediaPlayer

class Party {
    var name : String!
    var host : User!
    var playlist : [MPMediaItem] = []
    var partyID : String!   // Unique Party Identifier
    
    // Used for creating new parties and adding to Firebase
    init(_name : String, _host : User){
        name = _name
        host = _host
        partyID = NSUUID().UUIDString
    }
    
    // Used for populating data from Firebase DB
    init(_name: String, _host : User, _partyID : String){
        name = _name
        host = _host
        partyID = _partyID
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "hostedByUser": host!.email,
            "id": partyID
        ]
    }
}
