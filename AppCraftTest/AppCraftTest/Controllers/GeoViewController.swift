//
//  GeoViewController.swift
//  AppCraftTest
//
//  Created by Дарья on 21.12.2020.
//

import UIKit
import CoreLocation

class GeoViewController: UIViewController {

    @IBOutlet weak var currentGeoTextView: UITextView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func startSearchCurrentGeo(){
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func searchCurrentGeoTapped(_ sender: UIButton) {
        startSearchCurrentGeo()
    }
}

extension GeoViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last{
            currentGeoTextView.text = "\(lastLocation.coordinate.latitude) and \( lastLocation.coordinate.longitude)"
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        }
    }
}
