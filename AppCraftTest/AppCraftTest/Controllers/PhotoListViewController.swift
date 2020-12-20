//
//  TableViewController.swift
//  AppCraftTest
//
//  Created by Дарья on 19.12.2020.
//

import UIKit

class PhotoListViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var photos = [PhotoModel]()
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    func fetchData() {
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let id = id else {return}
        let urlString = "https://jsonplaceholder.typicode.com/photos?albumId=\(id)"
        
        NetworkManager.fetchPhotoData(urlString: urlString) { (photos) in
            self.photos = photos

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "photoCell" else {return}
        
        let indexPath = tableView.indexPathForSelectedRow!
        let photoVC = segue.destination as! PhotoViewController
        
        let photo = photos[indexPath.row]
        photoVC.imageString = photo.url
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoCell
        
        let photo = photos[indexPath.row]
        cell.configure(with: photo)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "photoSegue", sender: self)
    }
    
}
