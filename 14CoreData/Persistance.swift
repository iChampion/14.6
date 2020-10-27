//
//  Persistance.swift
//  14CoreData
//
//  Created by Sergey Lobanovskiy on 27.10.2020.
//

import Foundation

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

}
