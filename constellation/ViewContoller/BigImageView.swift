//
//  BigImageView.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/06.
//

import UIKit

class BigImageView: UIViewController {

    @IBOutlet var starImage: UIImageView!
    @IBOutlet var starIcon: UIImageView!

    var starImageUrl: URL? = nil
    var starIconUrl: URL? = nil
    
    override func viewDidLoad() {
        view.backgroundColor = .black
//        Nuke.loadImage(with: starImageUrl, into: starImage)
//        Nuke.loadImage(with: starIconUrl, into: starIcon)
<<<<<<< HEAD

=======
        
>>>>>>> refs/remotes/origin/main
        starImage.layer.borderWidth = 0.3
        starImage.layer.borderColor = UIColor.lightGray.cgColor
        starIcon.layer.borderWidth = 0.3
        starIcon.layer.borderColor = UIColor.lightGray.cgColor
    }

}
