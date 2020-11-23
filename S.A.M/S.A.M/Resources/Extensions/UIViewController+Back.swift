//
//  UIViewController+Back.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
   
    func customBackButton(title: String) {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(UIViewController.backButtonAction(sender:)))
        backButton.image = UIImage(named:"icn_back")
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func closeButton() {
        self.navigationItem.hidesBackButton = true
        let closeButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(UIViewController.closeButtonAction(sender:)))
        closeButton.image = UIImage(named:"icn_close")
        self.navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc func backButtonAction(sender: UIBarButtonItem?) {
        
    }
    
    @objc func closeButtonAction(sender: UIBarButtonItem) {
        
    }
}
