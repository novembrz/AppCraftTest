//
//  FavouriteViewController.swift
//  AppCraftTest
//
//  Created by Дарья on 21.12.2020.
//

import UIKit

class FavouriteViewController: UITableViewController {
    
    private var albums = RealmManager.albums

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        albums = realm.objects(AlbumRealmModel.self)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "favPhotoListSegue" else {return}
        let indexPath = tableView.indexPathForSelectedRow!
        let favPhotoVC = segue.destination as! PhotoListViewController
        favPhotoVC.favPhotos = albums[indexPath.row].photos
    }
    
    @IBAction func deleteAllAlbumsTapped(_ sender: UIBarButtonItem) {
        RealmManager.deleteAll(albums)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favAlbumCell", for: indexPath) as! FavAlbumCell
        
        let album = albums[indexPath.row]
        cell.titleLabel.text = album.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let album = albums[indexPath.row]
            RealmManager.deleteObject(album)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favPhotoListSegue", sender: self)
    }
}
