//
//  PartyMetaData.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 5/2/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import Foundation

class PartyMetaData {
    var name : String!
    var partyID : String!   // Unique Party Identifier
    var hostID : String!
    var hostEmail : String!
    var playlist : [SongMetaData] = []
    var didInitialFBQuery = false   // Used to prevent unnecessary FB queries
    
    
    // Used for creating new parties and adding to Firebase
    init(_name : String, _partyID : String, _hostID : String, _hostEmail : String){
        name = _name
        partyID = _partyID
        hostID = _hostID
        hostEmail = _hostEmail
    }
}