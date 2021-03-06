//
//  DashboardRouter.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import UIKit

class DashboardRouter {
    
    var dashboardViewController : UIViewController {
        return createViewController()
    }
    
    private var dashboardView: UIViewController?
    
    private func createViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardViewControllerId")
        
        return vc
    }
  
    func setDashboardView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { return }
        self.dashboardView = view
    }
    
    //MARK: - Navigations
    
    func navigateToList(with viewModel: ItemsListViewModel) {
        let storyboard = UIStoryboard(name: "ItemsList", bundle: nil)
        let vc : ItemsListViewController = storyboard.instantiateViewController(withIdentifier: "ItemsListViewControllerId") as! ItemsListViewController
        vc.viewModel = viewModel
        dashboardView?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
