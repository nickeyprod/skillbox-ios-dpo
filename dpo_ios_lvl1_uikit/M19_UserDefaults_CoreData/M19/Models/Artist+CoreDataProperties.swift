//
//  Artist+CoreDataProperties.swift
//  
//
//  Created by Николай Ногин on 20.08.2022.
//
//

import Foundation
import CoreData


extension Artist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
        return NSFetchRequest<Artist>(entityName: "Artist")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastName: String?
    @NSManaged public var birth: String?
    @NSManaged public var country: String?

}
