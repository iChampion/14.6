//
//  MainCore.swift
//  14CoreData
//
//  Created by Sergey Lobanovskiy on 31.10.2020.
//

import Foundation
import CoreData

class TaskCore {
    var name = ""
    var isComplete = false
}

class MainCore {
    static let shared = MainCore()
    
    //var ItemsCore: [TaskCore] = []
    
    var ItemsCore: [NSManagedObject] = []
    
    func addItem(nameItem: String) {
          
          // 1
          let managedContext = appDelegate.persistentContainer.viewContext
          
          // 2
          let entity =
            NSEntityDescription.entity(forEntityName: "Entity",
                                       in: managedContext)!
          
          let person = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
          
          // 3
          person.setValue(name, forKeyPath: "name")
          
          // 4
          do {
            try managedContext.save()
            people.append(person)
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
    func changeState(at index: Int) -> Bool {
        //ItemsCore[index].isComplete = !(ItemsCore[index].isComplete)
        
        return true
    }
    func moveItem(f:Int, to: Int){
        let select = ItemsCore[f]
        ItemsCore.remove(at: f)
        ItemsCore.insert(select, at: to)
        
    }
    func removeItem(at index: Int){
        //let select = ItemsCore[index]
        ItemsCore.remove(at: index)
    }
    func loadUsersData(){
    }
}
