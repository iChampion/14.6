//
//  ToDoEntities+CoreDataProperties.swift
//  
//
//  Created by Sergey Lobanovskiy on 05.11.2020.
//
//

import Foundation
import CoreData


extension ToDoEntities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoEntities> {
        return NSFetchRequest<ToDoEntities>(entityName: "ToDoEntities")
    }

    @NSManaged public var isComp: Bool
    @NSManaged public var name: String?

}
