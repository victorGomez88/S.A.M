//
//  CharactersListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class CharactersListViewModel {
    
    private weak var view: CharactersListViewController?
    private var router: CharactersListRouter?
    public var disposeBag = DisposeBag()

    func bind(view: CharactersListViewController, router: CharactersListRouter) {
        self.view = view
        self.router = router
    }
    
    func getCharactersListData(_ inputModel: CharactersInputModel?) -> Observable<CharactersModel> {
        return CharacterService.sharedInstance.getCharactersList(inputModel: inputModel)
    }
    
    func getData(with inputModel: Any?, onNextCompletion:(@escaping() -> Void)) {
    }
    
    func getMoreData(onNextCompletion:(@escaping() -> Void)) {
    }
    
    func haveMoreData(index: Int) -> Bool {
        return false
    }
    
    
    func getCountItems() -> Int {
        return 0
    }
    
    
    func getItemName(index: Int) -> String {
        return ""
    }
    
    func getImageName(index: Int) -> String {
        return ""
    }
   
}
