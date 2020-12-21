//
//  PhotoViewController.swift
//  AppCraftTest
//
//  Created by Дарья on 20.12.2020.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var imageString: String?
    var imageView = UIImageView()
    
    var imageScrollView: ImageScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        getImage()
    }
    
    func setupConstraints(){
        
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func getImage(){
        
        guard let imageString = imageString else {return}
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: imageString) else {return}
            guard let imageData = try? Data(contentsOf: imageURL) else {return}
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: imageData) else {return}
                self.imageScrollView.set(image: image)
            }
        }
    }
}
