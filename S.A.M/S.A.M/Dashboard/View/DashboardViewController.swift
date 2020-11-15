//
//  DashboardViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomHeaderConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layoutIfNeeded()
        self.headerView.frame = CGRect(x: 0, y: -44, width: self.headerView.frame.width, height: self.view.frame.height)
        
        UIView.animate(withDuration: 1.5) {
            self.bottomHeaderConstraint.constant = 0
            
            self.view.layoutIfNeeded()
        }
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
