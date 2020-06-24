//
//  RealmManager.swift
//  Tecomen
//
//  Created by Ngocnb on 6/23/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    private var realm: Realm = try! Realm()
    
    func saveObjects(_ obj: [Object]) {
        try! realm.write({
            realm.add(obj)
        })
    }
    
    func getAllObject<T: Object>(_ type: T.Type) -> [T] {
        let objects = realm.objects(type).toArray(ofType: T.self)
        return objects
    }
    
    // delete exactly an object with id and type
    func deleteObject(_ id: String, withType type: Object.Type) {
        let pedicate = NSPredicate(format: "id == %@", id)
        if let itemDelete = realm.objects(type).filter(pedicate).first {
            try! realm.write({
                realm.delete(itemDelete)
            })
        }
    }
    
    // delete all objects in Realm DB
    func deleteAllObjects() {
        try! realm.write({
            realm.deleteAll()
        })
    }
    
    func updateObject<T: Object>(_ object: T) {
        try! realm.write({
            realm.add(object, update: .modified)
        })
    }
    
    func checkObjectAreadyExisted(_ id: String, withType type: Object.Type) -> Bool {
        return realm.object(ofType: type, forPrimaryKey: id) != nil
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}

