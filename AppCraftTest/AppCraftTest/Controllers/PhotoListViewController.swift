//
//  TableViewController.swift
//  AppCraftTest
//
//  Created by Дарья on 19.12.2020.
//

import UIKit
import RealmSwift

class PhotoListViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveAlbumButton: UIBarButtonItem!
    
    private var photos = [PhotoModel]()
    var favPhotos = List<PhotoRealmModel>()
    
    var id: String?
    var albumTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        
        if favPhotos.isEmpty {
            
            activityIndicator.hidesWhenStopped = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            guard let id = id else {return}
            let urlString = "https://jsonplaceholder.typicode.com/photos?albumId=\(id)"
            
            DataFetcherServices.fetchPhotosData(urlString: urlString) { (photos) in
                guard let photos = photos else {return}
                self.photos = photos
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        } else {
            saveAlbumButton.isEnabled = false
            saveAlbumButton.tintColor = .clear
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "photoSegue" else {return}
        
        let indexPath = tableView.indexPathForSelectedRow!
        let photoVC = segue.destination as! PhotoViewController
        
        if favPhotos.isEmpty{
            let photo = photos[indexPath.row]
            photoVC.imageString = photo.url
        } else {
            let photo = favPhotos[indexPath.row]
            photoVC.imageData = photo.imageData
        }
    }
    
    @IBAction func saveAlbumButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let albumTitle = albumTitle else {return}
        let favPhotos = List<PhotoRealmModel>()
        
        DispatchQueue.global().sync {
            for el in self.photos{
                
                guard let imageURL = URL(string: el.url) else {return}
                guard let imageData = try? Data(contentsOf: imageURL) else {return}
                
                guard let imageThURL = URL(string: el.thumbnailUrl) else {return}
                guard let imageThData = try? Data(contentsOf: imageThURL) else {return}
                
                let favPhoto = PhotoRealmModel(title: el.title, imageData: imageData, imageThData: imageThData)
                
                favPhotos.append(favPhoto)
                print(favPhotos)
            }
            
            let favAlbum = AlbumRealmModel(title: albumTitle, photos: favPhotos)
            RealmManager.saveObject(favAlbum)
            
            print("ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО ВЫШЛО")
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !favPhotos.isEmpty {
            return favPhotos.count
        } else {
            return photos.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoCell
        
        if !favPhotos.isEmpty {
            let photo = favPhotos[indexPath.row]
            cell.configureFav(with: photo)
        }else {
            let photo = photos[indexPath.row]
            cell.configure(with: photo)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "photoSegue", sender: self)
    }
    
}
