//
//  Persistance.swift
//  14CoreData
//
//  Created by Sergey Lobanovskiy on 27.10.2020.
//

import Foundation
import RealmSwift

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}
class Persistance {
    static let shared = Persistance()
    
    private let kUserNameKey = "Persistance.kUserNameKey"
    private let kSecondNameKey = "Persistance.kSecondNameKey"

    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserNameKey) }
    }
    var secondName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kSecondNameKey) }
        get { return UserDefaults.standard.string(forKey: kSecondNameKey) }
    }
    private let realm = try! Realm()
    
    func test() {
        let dog = Dog()
        dog.name = "vvv"
        dog.age = 1
        try! realm.write {
            realm.add(dog)
        }
        
        //let allDogs = realm.objects(Dog.self)
        for dog in realm.objects(Dog.self){
            print("---" + dog.name + "\(dog.age)")
        }
    }

}
