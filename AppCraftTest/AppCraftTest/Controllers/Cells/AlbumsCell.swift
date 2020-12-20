//
//  AlbumsCell.swift
//  AppCraftTest
//
//  Created by Дарья on 20.12.2020.
//

import UIKit

class AlbumsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with model: AlbumModel){
        titleLabel.text = model.title
    }
}
