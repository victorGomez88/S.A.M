//
//  CreatorsListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class CreatorsListViewModel : ItemsListViewModel {
    
    private var creatorsService = CreatorsService.sharedInstance
    private var creators = [CreatorsResult]()
    private var creatorsModel : CreatorsOutputModel?
    private var moreData : Bool = false
    
    func getCreatorsListData(with inputModel: CreatorsInputModel?) -> Observable<CreatorsOutputModel> {
        return creatorsService.getCreatorsList(inputModel: inputModel, moreData: moreData)
    }
    
    override func getData(with inputModel: Any?, onNextCompletion: (@escaping() -> Void)) {
        return self.getCreatorsListData(with: nil)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
            
                self.creatorsModel = modelData
                self.creators = self.creatorsService.creatorsList
                onNextCompletion()
                
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func getMoreData(onNextCompletion:(@escaping() -> Void)) {
        
        let inputModel = CreatorsInputModel.init(offset: (self.creatorsModel?.data.offset ?? 0) + 20)
        
        return self.getCreatorsListData(with: inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
            
                self.creatorsModel = modelData
                self.creators = self.creatorsService.creatorsList
                onNextCompletion()
                
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func haveMoreData(index: Int) -> Bool {
        
        guard let creatorsModel = self.creatorsModel else { return false }
        
        moreData = creatorsModel.data.offset < creatorsModel.data.total
        
        return index == creatorsModel.data.offset + (creatorsModel.data.count - 1) && index < creatorsModel.data.total
    }
    
    override func getCountItems() -> Int {
        return creators.count
    }
    
    override func getImageName(index: Int) -> String {
        return creators[index].thumbnail.path + "." + creators[index].thumbnail.thumbnailExtension
    }
    
    override func getItemName(index: Int) -> String {
        return creators[index].firstName + " " + creators[index].lastName
    }
}
