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
    
    func navigateToCharactersList() {
        let storyboard = UIStoryboard(name: "CharactersList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CharactersListViewControllerId")
        dashboardView?.navigationController?.pushViewController(vc, animated: true)
    }
}
