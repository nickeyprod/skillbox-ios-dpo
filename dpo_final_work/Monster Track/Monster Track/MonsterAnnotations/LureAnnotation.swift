//
//  LureAnnotation.swift
//  Monster Track
//
//  Created by Николай Ногин on 25.12.2022.
//

import MapKit

class LureAnnotation: NSObject, MKAnnotation {
    
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    // Required if you set the annotation view's `canShowCallout` property to `true`
    var title: String?
    
    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        self.latitude = latitude
        self.longitude = longitude
        
        self.title = NSLocalizedString("lure", comment: "SF annotation")
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

    }
}


