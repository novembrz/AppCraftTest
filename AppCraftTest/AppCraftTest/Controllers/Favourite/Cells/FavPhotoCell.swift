//
//  FavPhotoCell.swift
//  AppCraftTest
//
//  Created by Дарья on 22.12.2020.
//

import UIKit

class FavPhotoCell: UITableViewCell {

    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var favLabel: UILabel!
    
    func configure(with model: PhotoRealmModel){
        favLabel.text = model.title
        
        DispatchQueue.global().sync  {
            let imageData = model.imageThData
            
            DispatchQueue.main.async  {
                self.favImageView.image = UIImage(data: imageData)
            }
        }
    }

}
