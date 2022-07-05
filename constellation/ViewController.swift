//
//  ViewController.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/05.
//

import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var lat = 0.0
    var lon = 0.0
    var MonthAndDay = ""
    var hour = ""
    var min = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        date()
    }
    func date() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd  HH mm"
        let dateStr = formatter.string(from: now as Date)
        let dataBase = dateStr.components(separatedBy: " ")
        MonthAndDay = dataBase[0]
        hour = dataBase[1]
        min = dataBase[2]
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = Double(location.coordinate.latitude)
        lon = Double(location.coordinate.longitude)
        let url = "https://livlog.xyz/hoshimiru/constellation?lat=\(lat)&lng=\(lon)&date=\(MonthAndDay)&hour=\(hour)&min=\(min)"
       
    }
    
}




