//
//  ItemsListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 19/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class ItemsListViewModel {
    
    weak var view: ItemsListViewController?
    var disposeBag = DisposeBag()
    var offset : Int?
    
    func bind(view: ItemsListViewController) {
        self.view = view
    }
    
    //MARK: - GET DATA FROM SERVICE
    func getData(searchedText: String, offset: Int, fromSearch: Bool, onNext: (@escaping() -> Void)) {
    }
    
    //MARK: - NAVIGATE TO DETAIL
    func obtainDetailVC(with index: Int) -> UIViewController? {
       return nil
    }
    
    func showWebDetail(with index: Int) {
      
    }
    
    func navigateToDetail(with id: Int) {
        if let vc = obtainDetailVC(with: id) {
            let nc = UINavigationController(rootViewController: vc)
            view?.present(nc, animated: true, completion: nil)
        } else {
            showWebDetail(with: id)
        }
    }
    
    //MARK: - TITLE VIEWCONTROLLER
    func obtainTitle() -> String {
        return ""
    }
    
    //MARK: - CELL CONFIGURATION
    func obtainCellName() -> String {
        return ""
    }
    
    func obtainCellHeight() -> CGFloat {
        return 0
    }
    
    func obtainCellCount() -> Int {
        return 0
    }
    
    func obtainCell(with tableView: UITableView, index: Int, searchedText: String?) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func hasMoreData(index: Int) -> Bool{
        return false
    }
    
    //MARK: -EMPTY STATE
    func showEmptyBackground() -> Bool {
        return false
    }
    
    func obtainEmptyMsg() -> String {
        return ""
    }
    
    //MARK: - SEARCH PLACEHOLDER
    func obtainSearchPlaceholder() -> String {
        return ""
    }
    
    //MARK: - ATTRIBUTION TEXT
    func obtainAttributionText() -> String {
        return ""
    }
    
}
