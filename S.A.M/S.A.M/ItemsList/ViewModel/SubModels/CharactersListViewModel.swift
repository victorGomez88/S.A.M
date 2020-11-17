//
//  CharactersListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class CharactersListViewModel : ItemsListViewModel {
    
    private var charactersService = CharacterService.sharedInstance
    private var characters = [CharactersResult]()
    private var characterModel : CharactersOutputModel?
    private var moreData : Bool = false
    
    func getCharactersListData(with inputModel: CharactersInputModel?) -> Observable<CharactersOutputModel> {
        return charactersService.getCharactersList(inputModel: inputModel, moreData: moreData)
    }
    
    override func getData(with inputModel: Any?, onNextCompletion: (@escaping() -> Void)) {
        return self.getCharactersListData(with: inputModel as? CharactersInputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.characterModel = modelData
                self.characters = self.charactersService.characterList
                onNextCompletion()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func getMoreData(onNextCompletion:(@escaping() -> Void)) {
        
        let inputModel = CharactersInputModel.init(offset: (self.characterModel?.data.offset ?? 0) + 20)
        
        return self.getCharactersListData(with: inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.characterModel = modelData
                self.characters = self.charactersService.characterList
                onNextCompletion()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func haveMoreData(index: Int) -> Bool {
        
        guard let characterModel = self.characterModel else { return false }
        
        moreData = characterModel.data.offset < characterModel.data.total
        
        return index == characterModel.data.offset + (characterModel.data.count - 1) && index < characterModel.data.total
    }
    
    override func getCountItems() -> Int {
        return characters.count
    }
    
    override func getImageName(index: Int) -> String {
        return characters[index].thumbnail.path + "." + characters[index].thumbnail.thumbnailExtension
    }
    
    override func getItemName(index: Int) -> String {
        return characters[index].name
    }
}
