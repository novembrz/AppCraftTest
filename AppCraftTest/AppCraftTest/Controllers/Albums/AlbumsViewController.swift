//
//  AlbumsViewController.swift
//  AppCraftTest
//
//  Created by Дарья on 20.12.2020.
//

import UIKit

class AlbumsViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var urlString = "https://jsonplaceholder.typicode.com/albums"
    private var albums = [AlbumModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.fetchAlbumsData { (albums) in
            self.albums = albums

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "photoListSegue" else { return }
        
        let indexPath = tableView.indexPathForSelectedRow!
        let photosVC = segue.destination as! PhotoListViewController
        
        let album = albums[indexPath.row]
        photosVC.id = String(album.id)
        photosVC.albumTitle = album.title
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumsCell", for: indexPath) as! AlbumsCell

        let album = albums[indexPath.row]
        cell.configure(with: album)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "photoListSegue", sender: self)
    }
    
}
