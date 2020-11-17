//
//  CharactersListRouter.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import UIKit

class CharactersListRouter {
    
    var charactersListViewController : UIViewController {
        return createViewController()
    }
    
    private var charactersListsourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "CharactersList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CharactersListViewControllerId")
                
        return vc
    }
    
    //Navigate to DETAIL
    
}
