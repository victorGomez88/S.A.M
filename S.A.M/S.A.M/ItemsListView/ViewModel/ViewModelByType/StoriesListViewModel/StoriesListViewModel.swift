//
//  StoriesListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 22/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class StoriesListViewModel: ItemsListViewModel {
    
    private var storyModel : StoriesModel?
    private var storiesList = [StoryModel]()
    
    public func getStoriesListData(_ inputModel: StoriesInputModel?) -> Observable<StoriesModel> {
        return StoriesService().getStoriesList(inputModel: inputModel)
    }
    
    //MARK: - GET DATA FROM SERVICE
    override func getData(searchedText: String? = "", offset: Int? = 0, fromSearch: Bool? = false, onNext: (@escaping() -> Void)) {
        let inputModel = StoriesInputModel.init(offset: offset)
        
        return getStoriesListData(inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                
                self.storyModel = modelData
                self.offset = self.storyModel?.data.offset
                
                if fromSearch ?? false {
                    self.storiesList = modelData.data.storiesList
                } else {
                    self.storiesList.append(contentsOf: modelData.data.storiesList)
                }
                
                onNext()

            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    
    }
    
    //MARK: - TITLE VIEWCONTROLLER
    override func obtainTitle() -> String {
        return NSLocalizedString("Stories", comment: "Stories")
    }

    //MARK: - CELL CONFIGURATION
    override func obtainCellName() -> String {
        return "StoryCell"
    }
    
    override func obtainCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func obtainCellCount() -> Int {
        return self.storiesList.count
    }
    
    override func obtainCell(with tableView: UITableView, index: Int, searchedText: String?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: obtainCellName()) as! StoryCell
        
        cell.selectionStyle = .none
        if let imageURL = storiesList[index].imageURL, let url = URL(string: imageURL.path + "." +  imageURL.thumbnailExtension) {
            cell.viewImageContainer.isHidden = false
            cell.imgLeftImageView.af.setImage(withURL:url, placeholderImage: UIImage(named:"placeholder"))
        } else {
            cell.viewImageContainer.isHidden = true
        }
        
        cell.lblTitleStory.text = storiesList[index].title
        
        return cell
    }
    
    override func hasMoreData(index: Int)  -> Bool {
    
        if let storyModel = self.storyModel {
            return index == (storiesList.count - 1) && index < (storyModel.data.total - 1)
        }
        
        return false
    }
    
    //MARK: -EMPTY STATE
    override func showEmptyBackground() -> Bool {
        return storiesList.count == 0
    }
    
    override func obtainEmptyMsg() -> String {
        return NSLocalizedString("StoriesEmptyTableMessage", comment: "StoriesEmptyTableMessage")
    }
    
    //MARK: - ATTRIBUTION TEXT
    override func obtainAttributionText() -> String {
        return storyModel?.attributionText ?? ""
    }
}
