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
//    let locServ = LocationService()
    
    let manager: CLLocationManager = {
        let locationManager = CLLocationManager()

        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //Точность измерения самой системой - чем она лучше, тем больше энергии потребляеет приложение. Задаётся через набор k-констант. Старайтесь использовать ту точность, что реально важна для приложения
        locationManager.distanceFilter = 10
        //Свойство отвечает за фильтр дистанции - величину, лишь при изменении на которую будет срабатывать изменение локации

        locationManager.pausesLocationUpdatesAutomatically = true
        //Позволяет системе автоматически останавливать обновление локации для балансировщика энергии
        
        locationManager.showsBackgroundLocationIndicator = true
        //С помощью этого свойства мы решаем, показывать или нет значок геопозиции для работы в фоновом режиме
        return locationManager
    }()
    
    var longitude: CLLocationDegrees!
    var latitude: CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    func startSearchCurrentGeo(){
//        locationManager.requestAlwaysAuthorization()
//
//        if CLLocationManager.locationServicesEnabled(){
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.pausesLocationUpdatesAutomatically = false
//            locationManager.startUpdatingLocation()
//
//        }
//        print(CLLocationManager.requestLocation(<#T##self: CLLocationManager##CLLocationManager#>))
//    }
    
    
    func getGeo(){
        
    }
    
    @IBAction func searchCurrentGeoTapped(_ sender: UIButton) {
        //startSearchCurrentGeo()
        getGeo()
        manager.delegate = self
        //Начало обновления позиции
        manager.startUpdatingLocation()
        
        print(longitude as Any, latitude as Any)
    }
}

extension GeoViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            //Статус авторизации
            switch status {
            //Если он не определён (то есть ни одного запроса на авторизацию не было, то попросим базовую авторизацию)
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            //Если она ограничена или запрещена, то уведомим об отключении
            case .restricted, .denied:
                print("Отключаем локацию")
            //Если авторизация базовая, то попросим предоставить полную
            case .authorizedWhenInUse:
                print("Включаем базовые функции")
                manager.requestAlwaysAuthorization()
            //Хи-хи
            case .authorizedAlways:
                print("Полный доступ")
            @unknown default:
                break
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            
            let coordinate = location.coordinate
            let timestamp = location.timestamp
            
            NSLog("Временная метка \(timestamp)\n")
            NSLog("Широта \(coordinate.latitude), долгота \(coordinate.longitude)\n")
            
            self.longitude = coordinate.longitude
            self.latitude = coordinate.latitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Если ошибку можно превратить в ошибку геопоозии, то сделаем это
        guard let locationError = error as? CLError else {
            //Иначе выведем как есть
            print(error)
            return
        }

        //Если получилось, то можно получить локализованное описание ошибки
        NSLog(locationError.localizedDescription)
    }
    
    
    
    
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let lastLocation = locations.last{
////            currentGeoTextView.text = "\(lastLocation.coordinate.latitude) and \( lastLocation.coordinate.longitude)"
//            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
//        }
//        print(locations.last?.coordinate)
//    }
}
