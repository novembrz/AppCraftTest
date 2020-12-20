//
//  PhotoModel.swift
//  AppCraftTest
//
//  Created by Дарья on 20.12.2020.
//

import Foundation

struct PhotoModel: Decodable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String //ссылка на основную картинку
    var thumbnailUrl: String //ссылка на превью картинки
}
