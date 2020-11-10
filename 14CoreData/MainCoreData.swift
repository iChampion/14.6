//
//  MainCoreData.swift
//  14CoreData
//
//  Created by Sergey Lobanovskiy on 05.11.2020.
//
import Foundation
import SwiftUI
import CoreData

class Task2 {
     var name = ""
     var isComplete = false
}

class MainCore {
    static let shared = MainCore()
    
    var tasks: [Task2] = []
    
    func save(name: String) {
        let item = Task2()
        item.name = name
        item.isComplete = false
        tasks.append(item)
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "ToDoEntities", into: context)
        entity.setValue(name, forKeyPath: "name")
        entity.setValue(false, forKeyPath: "isComp")
        do{
            try context.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func getTasks(){
        let app = UIApplication.shared.delegate as! AppDelegate
        // creating context from app delegate...
        let context = app.persistentContainer.viewContext
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoEntities")
        do{
            // going to fetch all data...
            let result = try context.fetch(req)
            tasks.removeAll()
            for i in result as! [NSManagedObject]{
                let task = i.value(forKey: "name") as! String
                let isComplate = i.value(forKey: "isComp") as! Bool
                let item = Task2()
                item.name = task
                item.isComplete = isComplate
                tasks.append(item)
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func changeState(at index: Int) -> Bool {
        tasks[index].isComplete = !(tasks[index].isComplete)
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoEntities")
        do{
            let result = try context.fetch(req)
            for i in result as! [NSManagedObject]{
                let currenttask = i.value(forKey: "name") as! String
                if tasks[index].name == currenttask{
                    i.setValue(tasks[index].isComplete, forKeyPath: "isComp")
                    try context.save()
                }
            }
        }
        catch{
            print(error.localizedDescription)
        }
        return tasks[index].isComplete
    }
    
    func changeName(at index: Int, name: String){
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoEntities")
        do{
            let result = try context.fetch(req)
            for i in result as! [NSManagedObject]{
                let currenttask = i.value(forKey: "name") as! String
                if tasks[index].name == currenttask{
                    i.setValue(name, forKeyPath: "name")
                    try context.save()
                    tasks[index].name = name
                }
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func moveItem(f:Int, to: Int){
        let select = tasks[f]
        tasks.remove(at: f)
        tasks.insert(select, at: to)
        
    }
    func DeleteTask(task: Int){
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoEntities")
        do{
            let result = try context.fetch(req)
            for i in result as! [NSManagedObject]{
                let currenttask = i.value(forKey: "name") as! String
                if tasks[task].name == currenttask{
                    context.delete(i)
                    try context.save()
                    tasks.remove(at: task)
                    return
                }
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}

