//
//  CreatorsListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class CreatorsListViewModel: ItemsListViewModel {
    
    private var creatorModel : CreatorsModel?
    private var creatorsList = [CreatorModel]()
    
    public func getCreatorsListData(_ inputModel: CreatorsInputModel?) -> Observable<CreatorsModel> {
        return CreatorsService().getCreatorsList(inputModel: inputModel)
    }
    
    override func showWebDetail(with index: Int) {
        creatorsList[index].urls.forEach { url in
            if url.type == "detail" && !url.url.isEmpty {
                if let url = URL(string: url.url) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    //MARK: - GET DATA FROM SERVICE
    override func getData(searchedText: String? = "", offset: Int? = 0, fromSearch: Bool? = false, onNext: (@escaping() -> Void)) {
        let inputModel = CreatorsInputModel.init(nameStartsWith: searchedText, offset: offset)
        
        return getCreatorsListData(inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                
                self.creatorModel = modelData
                self.offset = self.creatorModel?.data.offset
                
                if fromSearch ?? false {
                    self.creatorsList = modelData.data.creatorsList
                } else {
                    self.creatorsList.append(contentsOf: modelData.data.creatorsList)
                }
                
                onNext()

            }, onError: { error in
                let alert = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    self.view?.backButtonAction(sender: nil)
                }))
                
                self.view?.present(alert, animated: true)
            }).disposed(by: disposeBag)
    
    }
    
    //MARK: - TITLE VIEWCONTROLLER
    override func obtainTitle() -> String {
        return NSLocalizedString("Creators", comment: "Creators")
    }

    //MARK: - CELL CONFIGURATION
    override func obtainCellName() -> String {
        return "CreatorCell"
    }
    
    override func obtainCellHeight() -> CGFloat {
        return 100
    }
    
    override func obtainCellCount() -> Int {
        return self.creatorsList.count
    }
    
    override func obtainCell(with tableView: UITableView, index: Int, searchedText: String?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: obtainCellName()) as! CreatorCell
        
        cell.selectionStyle = .none
        if let url = URL(string: creatorsList[index].imageURL.path + "." +  creatorsList[index].imageURL.thumbnailExtension) {
            cell.imgLeftImageView.af.setImage(withURL: url, placeholderImage: UIImage(named:"placeholder"))
        }

        cell.lblFullName.text = creatorsList[index].fullName
        
        return cell
    }
    
    override func hasMoreData(index: Int)  -> Bool {
    
        if let creatorModel = self.creatorModel {
            return index == (creatorsList.count - 1) && index < (creatorModel.data.total - 1)
        }
        
        return false
    }
    
    //MARK: -EMPTY STATE
    override func showEmptyBackground() -> Bool {
        return creatorsList.count == 0
    }
    
    override func obtainEmptyMsg() -> String {
        return NSLocalizedString("CreatorsEmptyTableMessage", comment: "CreatorsEmptyTableMessage")
    }
    
    
    //MARK: - SEARCH PLACEHOLDER
    override func obtainSearchPlaceholder() -> String {
        return NSLocalizedString("CreatorsSearchPlaceholder", comment: "CreatorsSearchPlaceholder")
    }
    
    
    //MARK: - ATTRIBUTION TEXT
    override func obtainAttributionText() -> String {
        return creatorModel?.attributionText ?? ""
    }
}
