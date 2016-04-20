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
    
    init(_name : String, _host : User){
        name = _name
        host = _host
        partyID = NSUUID().UUIDString
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "partyID": partyID,
            "name": name,
            "hostedByUser": host!.email,
        ]
    }
}
