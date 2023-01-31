//
//  Constants.swift
//  Monster Track
//
//  Created by Николай Ногин on 15.12.2022.
//

import Foundation
import MapKit

enum Constants {
    
    static var POSSIBLE_MONSTERS = [
        "Sinay",
        "Gobinalex",
        "Cucukha",
        "Daddoo",
        "Bolemozh"
    ]
    
    // NUMBER OF MONSTERS PRESENTED ON MAP SIMUNTANIOUSLY WITHIN `MONSTERS_AREA_IN_METERS`
    static let MONSTERS_NUM = 30
    
    // IN WHICH AREA TO ACTUALLY ADD MONSTERS (INVISIBLE AREA AROUND USER)
    static let MONSTERS_AREA_IN_METERS: CLLocationDistance = 1000 // 1km
    
    // RADIUS AROUND USER IN METERS IN WHICH THOSE MONSTERS START TO BE VISIBLE
    static let RADIUS_IN_METERS: CLLocationDistance = 300 // 300 meters
    
    // DISTANCE ON WHICH USER CAN OPEN CATCH SCREEN
    static let OPEN_CATCH_METERS: CLLocationDistance = 100
    
    // PERCENT WITH WHICH MONSTER CAN RUN AWAY IF USER COULDN'T CATCH HIM FOR THE FIRST TIME
    static let RUN_AWAY_CHANCE = 50 // 50%
    
    
    // TIME IN SECONDS AFTER WHICH LIST OF MONSTERS UPDATES
    static let MONSTER_UPDATE_TIME: TimeInterval = 60 * 5 // 5 minutes
    
    // INITIAL CHANCE TO CATCH CLICKED MONSTER
    static let CHANCE_OF_CATCH = 20
    
    // NUM OF PERCENTS ON WHICH LURE INCREASES CHANCES TO CATCH MOSTER
    static let LURE_PERCENT_NUM = 35 // 35 percent
    
    // NUM OF PERCENTS OF CHANCE TO PLACE LURE ON MAP AROUND USER
    static let CHANCE_TO_PLACE_LURE = 20
    
    enum Colors {
        static var titleColor = "TitleColor"
    }
    
    enum UserDefaults {
        static var catchedMonsters = "catchedMonsters"
        static var lureCount = "lureCount"
    }
}
