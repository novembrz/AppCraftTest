//
//  TableViewCell.swift
//  AppCraftTest
//
//  Created by Дарья on 19.12.2020.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func configure(with model: PhotoModel){
        albumLabel.text = model.title
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: model.thumbnailUrl) else {return}
            guard let imageData = try? Data(contentsOf: imageURL) else {return}
            
            DispatchQueue.main.async {
                self.albumImageView.image = UIImage(data: imageData)
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func configureFav(with model: PhotoRealmModel){
        
        activityIndicator.isHidden = true
        albumLabel.text = model.title
        
        DispatchQueue.global().sync  {
            let imageData = model.imageThData
            
            DispatchQueue.main.async  {
                self.albumImageView.image = UIImage(data: imageData)
            }
        }
    }
}
