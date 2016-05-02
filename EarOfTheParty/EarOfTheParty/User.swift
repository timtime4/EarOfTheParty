//
//  User.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/11/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import Foundation
import Firebase

class User {
    let uid: String!
    let email: String!
    var partiesHosting : [Party] = []
    var partiesAttending : [PartyMetaData] = []
    
    // Initialize from Firebase
    init(authData: FAuthData) {
        uid = authData.uid
        email = authData.providerData["email"] as! String
    }
    
    // Initialize from arbitrary data
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
