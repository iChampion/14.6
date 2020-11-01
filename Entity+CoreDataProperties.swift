//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Sergey Lobanovskiy on 01.11.2020.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?
    @NSManaged public var isComp: Bool
    

}
