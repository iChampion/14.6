

import Foundation
import RealmSwift


class Task: Object {
    @objc dynamic var name = ""
    @objc dynamic var isComplete = false
}

class Main {
    static let shared = Main()
    
    var Items: [Task] = []
    let realm = try! Realm()
    
    func addItem(nameItem: String) {
        let item = Task()
        item.name = nameItem
        item.isComplete = false
        Items.append(item)
        
        try! realm.write { realm.add(item) }
    }
    func changeState(at index: Int) -> Bool {
        try! realm.write {
            Items[index].isComplete = !(Items[index].isComplete)
        }
        return Items[index].isComplete
    }
    func moveItem(f:Int, to: Int){
        let select = Items[f]
        Items.remove(at: f)
        Items.insert(select, at: to)
        
    }
    func removeItem(at index: Int){
        let select = Items[index]
        Items.remove(at: index)
        try! realm.write {
            realm.delete(select)
        }
    }
    func loadUsersData(){
        for user in realm.objects(Task.self) {
            Items.append(user)
        }
    }
}
