//
//  DataFetcherServices.swift
//  AppCraftTest
//
//  Created by Дарья on 23.12.2020.
//

import Foundation

struct DataFetcherServices {
    
    static func fetchAlbumsData(urlString: String, completion: @escaping ([AlbumModel]?) -> Void){
        NetworkManager.fetchData(urlString: urlString, completion: completion)
    }
    
    static func fetchPhotosData(urlString: String, completion: @escaping ([PhotoModel]?) -> Void){
        NetworkManager.fetchData(urlString: urlString, completion: completion)
    }
}
