//
//  ItemsListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class ItemsListViewModel {
    
    private weak var view: ItemsListViewController?
    private var router: ItemsListRouter?
    public var disposeBag = DisposeBag()

    
    func bind(view: ItemsListViewController, router: ItemsListRouter) {
        self.view = view
        self.router = router
    }
    
    func specificViewModel(itemType: APIConstants.ItemsType) -> ItemsListViewModel{
        switch itemType {
        
        case .Characters:
            return CharactersListViewModel()
        case .Comics:
            return ComicsListViewModel()
        case .Creators:
            return CreatorsListViewModel()
        case .Events:
            return EventsListViewModel()
        case .Series:
            return SeriesListViewModel()
        case .Stories:
            return StoriesListViewModel()
        }
    }
    
    //MARK: - GETTERS LIST ITEMS
    func getData(with inputModel: Any?, onNextCompletion:(@escaping() -> Void)) {
    }
    
    func getMoreData(onNextCompletion:(@escaping() -> Void)) {
    }
    
    func haveMoreData(index: Int) -> Bool {
        return false
    }
    
    //Return number of items
    func getCountItems() -> Int {
        return 0
    }
    
    //Return name item from row
    func getItemName(index: Int) -> String {
        return ""
    }
    
    //Return image name item from row
    func getImageName(index: Int) -> String {
        return ""
    }
   
}
