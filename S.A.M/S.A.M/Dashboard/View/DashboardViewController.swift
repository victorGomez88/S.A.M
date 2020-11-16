//
//  DashboardViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    //Header Vars
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var topHeaderTitle: NSLayoutConstraint!
    
    
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var viewScrollContainer: UIView!
    
    //Characters
    @IBOutlet weak var viewContainerCharacters: UIView!
    @IBOutlet weak var btnCharacters: UIButton!
    
    //Comics
    @IBOutlet weak var viewContainerComics: UIView!
    @IBOutlet weak var btnComics: UIButton!
    
    //Events
    @IBOutlet weak var viewContainerEvents: UIView!
    @IBOutlet weak var btnEvents: UIButton!
    
    private var router = DashboardRouter()
    private var viewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animatedTitleAndVisibleView()
        
        viewModel.bind(view: self, router: router)
        
        applyShadowAndCorner(to: viewContainerCharacters)
        applyShadowAndCorner(to: viewContainerComics)
        applyShadowAndCorner(to: viewContainerEvents)
        
    }
    
    
    //MARK: - Buttons actions
    
    @IBAction func btnActionCharacters(_ sender: Any) {
        //Navigate to Table Characters list
    }
    
    @IBAction func btnActionComics(_ sender: Any) {
        //Navigate to Table Comics list
    }
    
    @IBAction func btnActionEvents(_ sender: Any) {
        //Navigate to Table Events list
    }
    
    
    @IBAction func btnActionMenu(_ sender: Any) {
        //Open menu with the rest of options
    }
    
    private func applyShadowAndCorner(to view: UIView) {
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 10
        
    }
    
    //MARK: - Animation view
    /// Title like LaunchScreen animated to top and make visible dashboard view
    private func animatedTitleAndVisibleView() {
        
        self.viewScrollContainer.alpha = 0
        self.btnMenu.alpha = 0
        self.topHeaderTitle.constant = 200
        
        UIView.animate(withDuration: 1, delay: 0.5) {
            self.topHeaderTitle.constant = 75
            self.view.layoutIfNeeded()
        } completion: { completed in
            UIView.animate(withDuration: 0.5) {
                self.btnMenu.alpha = 1
                self.viewScrollContainer.alpha = 1
                self.view.layoutIfNeeded()
            }
        }

    }
}
