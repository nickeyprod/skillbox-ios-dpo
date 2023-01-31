//
//  ViewModel.swift
//  Monster Track
//
//  Created by Николай Ногин on 15.12.2022.
//

import Foundation
import MapKit

class ViewModel {
    
    var allMonsters: [MKAnnotation?] = []
    var catchedMonsters: [Monster?] = []
    
    weak var mapView: MKMapView?
    
    let defaults = UserDefaults.standard
    
    var updateTimer: Timer?
    
    // this needed for adding monsters for the first run
    var firstRun = true
    
    // user can use lure to increase the chance to catch monster
    var useLure = false
    var lureCount = 0
    
    init() {
        restoreFromCache()
    }
    
    func restoreFromCache() {
        
        // retrieve cached goods from UserDefaults
        if let data = defaults.object(forKey: Constants.UserDefaults.catchedMonsters) as? Data {
            if let catchedMonsters = try? JSONDecoder().decode([Monster].self, from: data) {
                self.catchedMonsters = catchedMonsters
            }
        }
        
        lureCount = defaults.integer(forKey: Constants.UserDefaults.lureCount)
    }
    
    func cacheGameState() {
        
        // To store in UserDefaults we need to JSON encode data
        if let encoded = try? JSONEncoder().encode(catchedMonsters) {
            defaults.set(encoded, forKey: Constants.UserDefaults.catchedMonsters)
        }
    
        defaults.set(lureCount, forKey: Constants.UserDefaults.lureCount)
    }
}
