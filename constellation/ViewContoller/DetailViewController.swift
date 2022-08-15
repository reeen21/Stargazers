//
//  ViewController.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/05.
//

import UIKit
import CoreLocation

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
    let hapticFeedback = UINotificationFeedbackGenerator()
    var results: Results!
    private var bigImageButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self

            // 何度動いたら更新するか（デフォルトは1度）
            locationManager.headingFilter = kCLHeadingFilterNone

            // デバイスのどの向きを北とするか（デフォルトは画面上部）
            locationManager.headingOrientation = .portrait
            locationManager.startUpdatingHeading()
        }
        view.backgroundColor = .black
        setData()
        bigImageButton = UIBarButtonItem(title: "大きい写真", style: .done, target: self, action: #selector(DetailImage(_:)))
        navigationItem.rightBarButtonItem = bigImageButton
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
    }

    //現在の端末の上部が指す方向（角度）を返す
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard let result = results else {return}
        let text = "".appendingFormat("%.0f", newHeading.magneticHeading)
        self.nowDirection.text = "端末の向き: \(text)°"
        let formattedNumLabel = "".appendingFormat("%.0f", result.directionNum)
        if text == formattedNumLabel {
            hapticFeedback.notificationOccurred(.success)
        }

    }
//各テキストにデータを入れる　fontやsizeを設定
    func setData() {
        guard let result = results else {return}
        altitudeNumLabel.text = "高度: \(result.altitudeNum)°"
        altitudeLabel.text = "高度: \(result.altitude)"
        contentLabel.text = "概説: \(result.content)"
        let formattedNumLabel = "".appendingFormat("%.0f", result.directionNum)
        directionNumLabel.text = "星座の方角: \(formattedNumLabel)°"
        directionLabel.text = "星座の方角: \(result.direction)"
        seasonLabel.text = "季節: \(result.season)"
        jpNameLabel.text = "\(result.jpName) / \(result.jpName)"
        originLabel.text = "起源: \(result.origin)"


        altitudeLabel.font = .systemFont(ofSize: 17.0)
        altitudeNumLabel.font = .systemFont(ofSize: 17.0)
        directionLabel.font = .systemFont(ofSize: 17.0)
        nowDirection.font = .systemFont(ofSize: 17.0)
        jpNameLabel.font = .systemFont(ofSize: 17.0)
        directionLabel.font = .systemFont(ofSize: 17.0)
        seasonLabel.font = .systemFont(ofSize: 17.0)
        originLabel.font = .systemFont(ofSize: 15.0)
        contentLabel.font = .systemFont(ofSize: 15.0)

        altitudeNumLabel.textColor = .systemRed
        altitudeLabel.textColor = .systemRed
        directionLabel.textColor = .systemRed
        nowDirection.textColor = .systemRed
        jpNameLabel.textColor = .systemRed
        directionNumLabel.textColor = .systemRed
        seasonLabel.textColor = .systemRed
        originLabel.backgroundColor = .clear
        originLabel.layer.borderWidth = 0.5
        originLabel.layer.borderColor = UIColor.darkGray.cgColor
        originLabel.textColor = .lightGray
        contentLabel.backgroundColor = .clear
        contentLabel.layer.borderWidth = 0.5
        contentLabel.layer.borderColor = UIColor.darkGray.cgColor
        contentLabel.textColor = .lightGray
        
        //let starImageUrl = result.starImageURL
        starImageView.layer.borderWidth = 0.3
        starImageView.layer.borderColor = UIColor.lightGray.cgColor
        //Nuke.loadImage(with: starImageUrl, into: starImageView)
        
        //let starIconUrl = result.starIconURL
        starIconImageView.layer.borderWidth = 0.3
        starIconImageView.layer.borderColor = UIColor.lightGray.cgColor
        //Nuke.loadImage(with: starIconUrl, into: starIconImageView)
    }

    //写真を表示する
    @objc func DetailImage(_ sender: UIBarButtonItem) {
        guard let result = results else {return}
        guard let detail = self.storyboard?.instantiateViewController(withIdentifier: "Big") as? BigImageView else {
            fatalError()
        }
        detail.starImageUrl = result.starImageURL
        detail.starIconUrl = result.starIconURL
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
