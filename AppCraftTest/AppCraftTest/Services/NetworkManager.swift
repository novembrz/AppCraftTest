//
//  AlbumManager.swift
//  AppCraftTest
//
//  Created by Дарья on 19.12.2020.
//

import Foundation

struct NetworkManager {
    
    static func fetchData<T: Decodable>(urlString: String, completion: @escaping (T?) -> Void) {
        
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
            
            let decoded = decodeJSON(type: T.self, from: data)
            completion(decoded)
        }
        task.resume()
        
    }
    
    static func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let error {
            print("Error serialization json", error)
            return nil
        }
    }
}

