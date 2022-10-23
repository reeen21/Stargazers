//
//  ViewController.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/06.
//
import CoreLocation
import UIKit
import Nuke

class ViewControllor: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var tableView: UITableView!
    private var result = [Results]()
    private var cellModel = [CellModel]()
    let locationManager = CLLocationManager()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        locationManager.delegate = self
        setLocationManager()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .black
        title = "Stargazers"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.systemRed
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.headingFilter = kCLHeadingFilterNone
        locationManager.headingOrientation = .portrait
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    
    //位置情報を取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let latitude = Double(location.coordinate.latitude)
        let longitude = Double(location.coordinate.longitude)
        viewModel.apiCaller(lati: latitude, log: longitude) { (result, cellModel) in
            self.result = result
            self.cellModel = cellModel
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


//MARK: - Extensions
extension ViewControllor: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ConstellationCell else {
            fatalError()
        }
        cell.configure(with: cellModel[indexPath.row])
        cell.backgroundColor = .black
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
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
