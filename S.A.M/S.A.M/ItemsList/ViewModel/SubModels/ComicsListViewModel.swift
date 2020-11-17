//
//  ComicsListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class ComicsListViewModel : ItemsListViewModel {
    
    private var comicsService = ComicsService.sharedInstance
    private var comics = [ComicsResult]()
    private var comicModel : ComicsOutputModel?
    private var moreData : Bool = false
    
    func getComicsListData(with inputModel: ComicsInputModel?) -> Observable<ComicsOutputModel> {
        return comicsService.getComicsList(inputModel: inputModel, moreData: moreData)
    }
    
    override func getData(with inputModel: Any?, onNextCompletion: (@escaping() -> Void)) {
        return self.getComicsListData(with: nil)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.comicModel = modelData
                self.comics = self.comicsService.comicsList
                onNextCompletion()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func getMoreData(onNextCompletion:(@escaping() -> Void)) {
        
        let inputModel = ComicsInputModel.init(offset: (self.comicModel?.data.offset ?? 0) + 20)
        
        return self.getComicsListData(with: inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.comicModel = modelData
                self.comics = self.comicsService.comicsList
                onNextCompletion()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func haveMoreData(index: Int) -> Bool {
        
        guard let comicModel = self.comicModel else { return false }
        
        moreData = comicModel.data.offset < comicModel.data.total
        
        return index == comicModel.data.offset + (comicModel.data.count - 1) && index < comicModel.data.total
    }
    
    override func getCountItems() -> Int {
        return comics.count
    }
    
    override func getImageName(index: Int) -> String {
        return comics[index].thumbnail.path + "." + comics[index].thumbnail.thumbnailExtension
    }
    
    override func getItemName(index: Int) -> String {
        return comics[index].title
    }
}
