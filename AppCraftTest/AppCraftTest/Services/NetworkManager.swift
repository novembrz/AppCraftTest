//
//  AlbumManager.swift
//  AppCraftTest
//
//  Created by Дарья on 19.12.2020.
//

import Foundation

struct NetworkManager {
    
    static func fetchAlbumsData(completion: @escaping (_ courses: [AlbumModel])->()){
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, let response = response else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            print(response)
            
            do {
                let decoder = JSONDecoder()
                let albums = try decoder.decode([AlbumModel].self, from: data)
                completion(albums)
            } catch let error {
                print("Error serialization json", error)
            }
        }
        task.resume()
    }
    
    static func fetchPhotoData(urlString: String, completion: @escaping (_ courses: [PhotoModel]) -> ()){
        
        guard let url = URL(string: urlString) else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, let response = response else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            print(response)
            
            do {
                let decoder = JSONDecoder()
                let albums = try decoder.decode([PhotoModel].self, from: data)
                completion(albums)
            } catch let error {
                print("Error serialization json", error)
            }
        }
        task.resume()
    }
}

