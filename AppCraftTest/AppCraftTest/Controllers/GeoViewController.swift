//
//  GeoViewController.swift
//  AppCraftTest
//
//  Created by Дарья on 22.12.2020.
//

import UIKit
import CoreLocation
import AVFoundation

class GeoViewController: UIViewController {

    @IBOutlet weak var geoButton: UIButton!
    @IBOutlet weak var geoLabel: UILabel!
    
    var geoState = false
    
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    var player: AVAudioPlayer?
    
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
    
    private func playAudio(){
        let urlString = Bundle.main.path(forResource: "Rihanna", ofType: "mp3")
        do{
            let shared = AVAudioSession.sharedInstance()
            try shared.setMode(.default)
            try shared.setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {return}
            let url = URL(fileURLWithPath: urlString)
            
            player = try AVAudioPlayer(contentsOf: url)
            
            guard let player = player else {
                return
            }
            player.play()
            
        }catch{
            print("Something audio wrong")
        }
    }
    
    @IBAction func geoButtonTapped(_ sender: UIButton) {
        
        geoState = !geoState
        
        if CLLocationManager.locationServicesEnabled(){
            
            if geoState == true {
                locationManager.startUpdatingLocation()
                geoButton.setTitle("Stop search", for: .normal)
                print("start UpdatingLocation")
                
                playAudio()
                
            } else {
                locationManager.stopUpdatingLocation()
                geoButton.setTitle("Start search", for: .normal)
                print("stop UpdatingLocation")
                
                if let player = player, player.isPlaying {
                    player.stop()
                }
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
