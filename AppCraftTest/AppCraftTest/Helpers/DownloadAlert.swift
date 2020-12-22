//
//  DownloadAlert.swift
//  AppCraftTest
//
//  Created by Дарья on 22.12.2020.
//

import UIKit

class DownloadAlert {
    
    static func showAlert(vc: UIViewController){

        let alert = UIAlertController(title: "Downloading...", message: "0%", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let hight = NSLayoutConstraint(item: alert.view!,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .notAnAttribute,
                                       multiplier: 0,
                                       constant: 170)
        
        alert.view.addConstraint(hight)

        alert.addAction(cancelAction)
        vc.present(alert, animated: true) {
            
            let size = CGSize(width: 40, height: 40)
            let point = CGPoint(x: alert.view.frame.width / 2 - size.width / 2,
                                y: alert.view.frame.height / 2 - size.height / 2)
            
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: point, size: size))
            activityIndicator.color = .gray
            activityIndicator.startAnimating()
            
            alert.view.addSubview(activityIndicator)
        }
    }
}
