//
//  LoaderView.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit

class LoaderView: UIView {

    @IBOutlet weak var loaderImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    override func awakeFromNib() {
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
        loaderImageView?.startAnimating()
    }
    
    func stopLoader() {
        loaderImageView?.stopAnimating()
    }

}
