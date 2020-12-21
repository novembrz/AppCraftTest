//
//  RealmModel.swift
//  AppCraftTest
//
//  Created by Дарья on 21.12.2020.
//

import RealmSwift

class AlbumRealmModel: Object{
    @objc dynamic var title = ""
    var photos = List<PhotoRealmModel>()
    
    convenience init(title: String, photos: List<PhotoRealmModel>){
        self.init()
        self.title = title
        self.photos = photos
    }
}

class PhotoRealmModel: Object{
    @objc dynamic var title = ""
    @objc dynamic var imageData = Data()
    @objc dynamic var imageThData = Data()
    
    convenience init(title: String, imageData: Data, imageThData: Data){
        self.init()
        self.title = title
        self.imageData = imageData
        self.imageThData = imageThData
    }
}


