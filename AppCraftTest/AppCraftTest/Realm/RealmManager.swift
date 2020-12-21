//
//  RealmManager.swift
//  AppCraftTest
//
//  Created by Дарья on 21.12.2020.
//

import RealmSwift

let realm = try! Realm()

class RealmManager {
    
    static var albums: Results<AlbumRealmModel> {
        return realm.objects(AlbumRealmModel.self)
    }
    
    static func saveObject(_ album: AlbumRealmModel) {
        try! realm.write {
            realm.add(album)
        }
    }
    
    static func deleteObject(_ album: AlbumRealmModel) {
        try! realm.write {
            realm.delete(album)
        }
    }
    
}


