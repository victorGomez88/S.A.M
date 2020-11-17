//
//  StoriesListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class StoriesListViewModel : ItemsListViewModel {

    private var storiesService = StoriesService.sharedInstance
    private var stories = [StoriesResult]()
    private var storyModel : StoriesOutputModel?
    private var moreData : Bool = false
    
    func getStoriesListData(with inputModel: StoriesInputModel?) -> Observable<StoriesOutputModel> {
        return storiesService.getStoriesList(inputModel: inputModel, moreData: moreData)
    }

    override func getData(with inputModel: Any?, onNextCompletion: (@escaping() -> Void)) {
        return self.getStoriesListData(with: nil)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.storyModel = modelData
                self.stories = self.storiesService.storiesList
                onNextCompletion()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func getMoreData(onNextCompletion:(@escaping() -> Void)) {
        
        let inputModel = StoriesInputModel.init(offset: (self.storyModel?.data.offset ?? 0) + 20)
        
        return self.getStoriesListData(with: inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.storyModel = modelData
                self.stories = self.storiesService.storiesList
                onNextCompletion()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func haveMoreData(index: Int) -> Bool {
        
        guard let storyModel = self.storyModel else { return false }
        
        moreData = storyModel.data.offset < storyModel.data.total
        
        return index == storyModel.data.offset + (storyModel.data.count - 1) && index < storyModel.data.total
    }
    
    override func getCountItems() -> Int {
        return stories.count
    }
    
    override func getImageName(index: Int) -> String {
        guard let thumbnail = stories[index].thumbnail else { return ""}
        return thumbnail.path + "." + thumbnail.thumbnailExtension
    }
    
    override func getItemName(index: Int) -> String {
        return stories[index].title
    }
}
