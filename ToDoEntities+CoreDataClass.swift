//
//  ToDoEntities+CoreDataClass.swift
//  14CoreData
//
//  Created by Sergey Lobanovskiy on 01.11.2020.
//
//

import Foundation
import CoreData

@objc(ToDoEntities)
public class ToDoEntities: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "ToDoEntities"), insertInto: CoreDataManager.instance.managedObjectContext)
    }}
