//
//  Party.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 4/13/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import Foundation

class Party {
    var name : String?
    var host : User?
    var playlist : [String] = []
    
    init(_name : String, _host : User){
        name = _name
        host = _host
    }
}
