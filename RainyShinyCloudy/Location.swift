//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Hector Partidas on 1/28/17.
//  Copyright © 2017 Hector Partidas. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
