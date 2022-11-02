//
//  ViewController.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/05.



import UIKit
import CoreLocation
import Nuke
import AudioToolbox

final class DetailViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet private weak var starImageView: UIImageView!
    @IBOutlet private weak var starIconImageView: UIImageView!
    @IBOutlet private weak var altitudeNumLabel: UILabel!
    @IBOutlet private weak var directionLabel: UILabel!
    @IBOutlet private weak var directionNumLabel: UILabel!
    @IBOutlet private weak var seasonLabel: UILabel!
    @IBOutlet private weak var nowDirection: UILabel!
    @IBOutlet private weak var altitudeLabel: UILabel!
    @IBOutlet private weak var jpNameLabel: UILabel!
    @IBOutlet private weak var originLabel: UITextView!
    @IBOutlet private weak var contentLabel: UITextView!
    
    private let locationManager = CLLocationManager()
    var results: Results!
    private var bigImageButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        setLocationManager()
        view.backgroundColor = .black
        setData()
        bigImageButton = UIBarButtonItem(title: "大きい写真", style: .done, target: self, action: #selector(DetailImage(_:)))
        navigationItem.rightBarButtonItem = bigImageButton
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
    }
    
    private func setLocationManager() {
        // 何度動いたら更新するか（デフォルトは1度）
        locationManager.headingFilter = kCLHeadingFilterNone
        // デバイスのどの向きを北とするか（デフォルトは画面上部）
        locationManager.headingOrientation = .portrait
        locationManager.startUpdatingHeading()
    }
    
    
    //現在の端末の上部が指す方向（角度）を返す
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard let results else {return}
        let text = "".appendingFormat("%.0f", newHeading.magneticHeading)
        self.nowDirection.text = "端末の向き: \(text)°"
        let formattedNumLabel = "".appendingFormat("%.0f", results.directionNum)
        if text == formattedNumLabel {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        
    }
    
    //各テキストにデータを入れる　fontやsizeを設定
    private func setData() {
        guard let results else {return}
        altitudeNumLabel.text = "高度: \(results.altitudeNum)°"
        altitudeLabel.text = "高度: \(results.altitude)"
        let formattedNumLabel = "".appendingFormat("%.0f", results.directionNum)
        directionNumLabel.text = "星座の方角: \(formattedNumLabel)°"
        directionLabel.text = "星座の方角: \(results.direction)"
        seasonLabel.text = "季節: \(results.season)"
        jpNameLabel.text = "\(results.jpName) / \(results.enName)"
        
        if results.origin == "なし" {
            originLabel.text = "データがありません"
        } else {
            originLabel.text = "起源: \(results.origin)"
        }
        
        if results.content == "なし" {
            contentLabel.text = "データがありません"
        } else {
            contentLabel.text = "概説: \(results.content)"
        }
        setTextStyle()
        setImages()
    }
    
    private func setTextStyle() {
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
    }
    
    private func setImages() {
        guard let results else {return}
        let starImageUrl = results.starImageURL
        starImageView.layer.borderWidth = 0.3
        starImageView.layer.borderColor = UIColor.lightGray.cgColor
        Nuke.loadImage(with: starImageUrl, into: starImageView)
        
        let starIconURL = results.starIconURL
        starIconImageView.layer.borderWidth = 0.3
        starIconImageView.layer.borderColor = UIColor.lightGray.cgColor
        Nuke.loadImage(with: starIconURL, into: starIconImageView)
    }
    
    //写真を表示する
    @objc func DetailImage(_ sender: UIBarButtonItem) {
        guard let results else {return}
        guard let detail = self.storyboard?.instantiateViewController(withIdentifier: "Big") as? BigImageView else {
            fatalError()
        }
        detail.starImageUrl = results.starImageURL
        detail.starIconUrl = results.starIconURL
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
