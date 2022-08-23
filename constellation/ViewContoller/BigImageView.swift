//
//  BigImageView.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/06.
//
<<<<<<< HEAD
=======

>>>>>>> 4a53e51ead91fab7dfe51d87df64f31f08b9597d
import UIKit
import Nuke

class BigImageView: UIViewController {

    @IBOutlet var starImage: UIImageView!
    @IBOutlet var starIcon: UIImageView!

    var starImageUrl: URL? = nil
    var starIconUrl: URL? = nil
    
    override func viewDidLoad() {
        view.backgroundColor = .black
<<<<<<< HEAD
<<<<<<< HEAD
        Nuke.loadImage(with: starImageUrl, into: starImage)
        Nuke.loadImage(with: starIconUrl, into: starIcon)
=======
//        Nuke.loadImage(with: starImageUrl, into: starImage)
//        Nuke.loadImage(with: starIconUrl, into: starIcon)
>>>>>>> 171410c (reset)
=======
        Nuke.loadImage(with: starImageUrl, into: starImage)
        Nuke.loadImage(with: starIconUrl, into: starIcon)
>>>>>>> 4a53e51ead91fab7dfe51d87df64f31f08b9597d

        starImage.layer.borderWidth = 0.3
        starImage.layer.borderColor = UIColor.lightGray.cgColor
        starIcon.layer.borderWidth = 0.3
        starIcon.layer.borderColor = UIColor.lightGray.cgColor

        navigationController?.navigationBar.tintColor = UIColor.systemRed
    }
}
