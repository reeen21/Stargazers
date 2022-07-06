//
//  ViewController.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/05.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import Nuke

class DetailViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var starImageView: UIImageView!
    @IBOutlet var starIconImageView: UIImageView!
    @IBOutlet var altitudeNumLabel: UILabel!
    @IBOutlet var directionLabel: UILabel!
    @IBOutlet var directionNumLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var nowDirection: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var jpNameLabel: UILabel!
    @IBOutlet var originLabel: UITextView!
    @IBOutlet var contentLabel: UITextView!
    
    let locationManager = CLLocationManager()
    var lat = 0.0
    var lon = 0.0
    var MonthAndDay = ""
    var hour = ""
    var min = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.headingFilter = kCLHeadingFilterNone
            locationManager.headingOrientation = .portrait
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
        AF.request("https://livlog.xyz/hoshimiru/constellation?lat=\(lat)&lng=\(lon)&date=\(MonthAndDay)&hour=\(hour)&min=\(min)").response { response in
            if let responseStr = response.value {
                let jsonResponse = JSON(responseStr!)
                let result = jsonResponse["result"].array![0]
                
                self.altitudeNumLabel.text = "高度: \(result["altitudeNum"].stringValue)°"
                self.contentLabel.text = "概説: \(result["content"].stringValue)"
                self.directionNumLabel.text = "方角(°)\(result["directionNum"].stringValue)"
                self.directionLabel.text = "方角: \(result["direction"].stringValue)"
                self.seasonLabel.text = "季節: \(result["season"].stringValue)"
                self.jpNameLabel.text = "\(result["jpName"].stringValue) / \(result["enName"].stringValue)"
                self.originLabel.text = "起源: \(result["origin"].stringValue)"
                self.altitudeLabel.text = result["altitude"].stringValue
                self.nowDirection.text = "今の方角"
                
                self.altitudeNumLabel.textColor = .white
                self.altitudeLabel.textColor = .white
                self.directionLabel.textColor = .white
                self.nowDirection.textColor = .white
                self.jpNameLabel.textColor = .white
                self.directionNumLabel.textColor = .white
                self.seasonLabel.textColor = .white
                self.originLabel.backgroundColor = .clear
                self.originLabel.textColor = .white
                self.contentLabel.backgroundColor = .clear
                self.contentLabel.textColor = .white

                
                let starImage = result["starImage"].stringValue
                let starImageUrl = URL(string: starImage)!
                Nuke.loadImage(with: starImageUrl, into: self.starImageView)
                
                let starIcon = result["starIcon"].stringValue
                let sratIconUrl = URL(string: starIcon)!
                Nuke.loadImage(with: sratIconUrl, into: self.starIconImageView)
                
            }
            
        }
    }
    
}




