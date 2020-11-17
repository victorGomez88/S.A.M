//
//  ItemsListRouter.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import UIKit

class ItemsListRouter {
    
    var itemsListViewController : UIViewController {
        return createViewController()
    }
    
    private var itemsListsourceView: UIViewController?
    var itemType: APIConstants.ItemsType?
    
    init(itemType: APIConstants.ItemsType? = .Characters) {
        self.itemType = itemType
    }
    
    private func createViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "ItemsList", bundle: nil)
        let vc : ItemsListViewController = storyboard.instantiateViewController(withIdentifier: "ItemsListViewControllerId") as! ItemsListViewController
        vc.itemType = self.itemType
        
        return vc
    }
    
}
