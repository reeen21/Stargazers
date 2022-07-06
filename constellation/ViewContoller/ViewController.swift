//
//  ViewController.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/06.
//

import CoreLocation
import UIKit

class ViewControllor: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    private var result = [Results]()
    private var cellModel = [CellViewModel]()
    let locationManager = CLLocationManager()
    
    var lat = 0.0
    var lon = 0.0
    var MonthAndDay = ""
    var hour = ""
    var min = ""
    
    override func viewDidLoad() {
        date()
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
        APICaller.shared.getInfo(lat: lat, lon: lon, MonthAndDay: MonthAndDay, hour: hour, min: min) { result in
            switch result {
            case .success(let articles):
                self.result = articles
                self.cellModel = articles.compactMap({
                    CellViewModel(
                        jpName: $0.jpName,
                        enName: $0.enName,
                        direction: $0.direction)
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let err):
                print("検索時にerrorが発生しました:\(err)")
            }
        }
    }
}

extension ViewControllor: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? constellationTableViewCell else {
            fatalError()
        }
        cell.configure(with: cellModel[indexPath.row])
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        detail.results = result[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
