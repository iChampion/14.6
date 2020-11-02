//
//  ToDoEntities+CoreDataProperties.swift
//  14CoreData
//
//  Created by Sergey Lobanovskiy on 01.11.2020.
//
//

import Foundation
import CoreData


extension ToDoEntities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoEntities> {
        return NSFetchRequest<ToDoEntities>(entityName: "ToDoEntities")
    }

    @NSManaged public var name: String?
    @NSManaged public var isComp: Bool

}

extension ToDoEntities : Identifiable {

}
