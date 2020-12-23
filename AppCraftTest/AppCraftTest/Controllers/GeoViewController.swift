//
//  GeoViewController.swift
//  AppCraftTest
//
//  Created by Дарья on 22.12.2020.
//

import UIKit
import CoreLocation

class GeoViewController: UIViewController {

    @IBOutlet weak var geoButton: UIButton!
    @IBOutlet weak var geoLabel: UILabel!
    
    var geoState = false
    
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func geoButtonTapped(_ sender: UIButton) {
        
        geoState = !geoState
        
        if CLLocationManager.locationServicesEnabled(){
            if geoState == true {
                //  locationManager.requestLocation()
                locationManager.startUpdatingLocation()
                geoButton.setTitle("Stop search", for: .normal)
                print("start UpdatingLocation")
                
            } else {
                locationManager.stopUpdatingLocation()
                geoButton.setTitle("Start search", for: .normal)
                print("stop UpdatingLocation")
            }
        }
    }
}

extension GeoViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        print("\(longitude), \(latitude)")
        
        DispatchQueue.main.async {
            self.geoLabel.text = "longitude = \(longitude), latitude = \(latitude)"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
