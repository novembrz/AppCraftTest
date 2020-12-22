//
//  FavPhotoViewController.swift
//  AppCraftTest
//
//  Created by Дарья on 21.12.2020.
//

import UIKit
import RealmSwift

class FavPhotoViewController: UITableViewController {
    
    var photos = List<PhotoRealmModel>()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "favPhotoSegue" else {return}
        let photoVC = segue.destination as! PhotoViewController
        let indexPath = tableView.indexPathForSelectedRow!
        
        let photo = photos[indexPath.row]
        photoVC.imageData = photo.imageData
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favPhotoCell") as! FavPhotoCell
        
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favPhotoSegue", sender: self)
    }
    
}
