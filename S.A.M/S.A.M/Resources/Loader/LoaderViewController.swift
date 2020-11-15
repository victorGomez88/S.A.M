//
//  LoaderViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var loaderImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.alpha = 0.2

        var imageArray = [UIImage]()
        var i = 0
        while let image = UIImage(named: "Loader/\(i)") {
            imageArray.append(image)
            i += 1
        }

        loaderImageView.animationImages = imageArray
        loaderImageView.animationDuration = 1.5
        loaderImageView.animationRepeatCount = 0
        loaderImageView.image = loaderImageView.animationImages?.first
        
    }
    
    func startLoader() {
        loaderImageView.startAnimating()
    }
    
    func stopLoader() {
        loaderImageView.stopAnimating()
    }


}
