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
    
    //Creators
    @IBOutlet weak var viewContainerCreators: UIView!
    @IBOutlet weak var btnCreators: UIButton!
    
    //Series
    @IBOutlet weak var viewContainerSeries: UIView!
    @IBOutlet weak var btnSeries: UIButton!
    
    //Stories
    @IBOutlet weak var viewContainerStories: UIView!
    @IBOutlet weak var btnStories: UIButton!
    
    
    private var router = DashboardRouter()
    private var viewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        animatedTitleAndVisibleView()
        
        viewModel.bind(view: self, router: router)
        
        btnCharacters.titleLabel?.text = NSLocalizedString("Characters", comment: "Characters")
        btnComics.titleLabel?.text = NSLocalizedString("Comics", comment: "Comics")
        btnEvents.titleLabel?.text = NSLocalizedString("Events", comment: "Events")
        btnCreators.titleLabel?.text = NSLocalizedString("Creators", comment: "Creators")
        btnSeries.titleLabel?.text = NSLocalizedString("Series", comment: "Series")
        btnStories.titleLabel?.text = NSLocalizedString("Stories", comment: "Stories")
        
        applyShadowAndCorner(to: viewContainerCharacters)
        applyShadowAndCorner(to: viewContainerComics)
        applyShadowAndCorner(to: viewContainerEvents)
        applyShadowAndCorner(to: viewContainerCreators)
        applyShadowAndCorner(to: viewContainerSeries)
        applyShadowAndCorner(to: viewContainerStories)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    //MARK: - Buttons actions
    
    @IBAction func btnActionCharacters(_ sender: Any) {
        //Navigate to Table Characters list
        router.navigateToList(with: CharactersListViewModel())
    }
    
    @IBAction func btnActionComics(_ sender: Any) {
        //Navigate to Table Comics list
        router.navigateToList(with: ComicsListViewModel())
    }
    
    @IBAction func btnActionEvents(_ sender: Any) {
        //Navigate to Table Events list
        router.navigateToList(with: EventsListViewModel())
    }
    
    @IBAction func btnActionCreators(_ sender: Any) {
        //Navigate to Table Creators list
        router.navigateToList(with: CreatorsListViewModel())
    }
    
    @IBAction func btnActionSeries(_ sender: Any) {
        //Navigate to Table Series list
//        router.navigateToItemsList(with: .Series)
    }
    
    @IBAction func btnActionStories(_ sender: Any) {
        //Navigate to Table Stories list
//        router.navigateToItemsList(with: .Stories)
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
        self.topHeaderTitle.constant = 200
        
        UIView.animate(withDuration: 1, delay: 0.5) {
            self.topHeaderTitle.constant = 75
            self.view.layoutIfNeeded()
        } completion: { completed in
            UIView.animate(withDuration: 0.5) {
                self.viewScrollContainer.alpha = 1
                self.view.layoutIfNeeded()
            }
        }

    }
}
