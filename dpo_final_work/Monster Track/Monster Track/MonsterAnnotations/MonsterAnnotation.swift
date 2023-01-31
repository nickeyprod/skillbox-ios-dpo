//
//  Monster.swift
//  Monster Track
//
//  Created by Николай Ногин on 19.12.2022.
//

import MapKit

class MonsterAnnotation: NSObject, MKAnnotation {
    
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var monster: Monster
    
    // Required if you set the annotation view's `canShowCallout` property to `true`
    var title: String?
    
    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    init(monster: Monster, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        self.monster = monster
        self.latitude = latitude
        self.longitude = longitude
        
        self.title = NSLocalizedString(self.monster.name, comment: "SF annotation")
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

    }
}



