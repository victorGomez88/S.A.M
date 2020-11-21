//
//  ComicsListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 19/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ComicsListViewModel : ItemsListViewModel {
    
    private var comicsModel : ComicsModel?
    private var comicsList = [ComicModel]()

    
    func getComicsListData(_ inputModel: ComicsInputModel?) -> Observable<ComicsModel> {
        return ComicsService().getComicsList(inputModel: inputModel)
    }
    
    override func obtainDetailVC(with index: Int) -> UIViewController{
        let storyboard = UIStoryboard(name: "ComicDetail", bundle: nil)
        let vc : ComicDetailViewController = storyboard.instantiateViewController(withIdentifier: "ComicDetailViewControllerId") as! ComicDetailViewController
        vc.comicId = comicsList[index].id
        return vc
    }
    
    //MARK: - GET DATA FROM SERVICE
    override func getData(searchedText: String? = "", offset: Int? = 0, fromSearch: Bool? = false, onNext: (@escaping() -> Void)) {
        let inputModel = ComicsInputModel.init(titleStartsWith: searchedText, offset: offset)
        
        return getComicsListData(inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                
                self.comicsModel = modelData
                self.offset = self.comicsModel?.data.offset
                
                if fromSearch ?? false {
                    self.comicsList = modelData.data.comicsList
                } else {
                    self.comicsList.append(contentsOf: modelData.data.comicsList)
                }
                
                onNext()

            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    
    }
    
    //MARK: - TITLE VIEWCONTROLLER
    override func obtainTitle() -> String {
        return NSLocalizedString("Comics", comment: "Comics")
    }

    //MARK: - CELL CONFIGURATION
    override func obtainCellName() -> String {
        return "ComicCell"
    }
    
    override func obtainCellHeight() -> CGFloat {
        return 120
    }
    
    override func obtainCellCount() -> Int {
        return self.comicsList.count
    }
    
    override func obtainCell(with tableView: UITableView, index: Int, searchedText: String?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: obtainCellName()) as! ComicCell
        cell.selectionStyle = .none
        
        if let url = URL(string: comicsList[index].imageURL.path + "." +  comicsList[index].imageURL.thumbnailExtension) {
            cell.comicImage.af.setImage(withURL:url)
        }

        cell.lblComicName.text = comicsList[index].title
        cell.lblComicFormat.text = comicsList[index].format
        cell.lblIssueNumber.text = comicsList[index].issueNumber > 0 ? String(format:"Issue #%d", comicsList[index].issueNumber) : ""
        
        return cell
    }
    
    override func hasMoreData(index: Int)  -> Bool {
    
        if let comicsModel = self.comicsModel {
            return index == (comicsList.count - 1) && index < (comicsModel.data.total - 1)
        }
        
        return false
    }
    
    //MARK: -EMPTY STATE
    override func showEmptyBackground() -> Bool {
        return comicsList.count == 0
    }
    
    override func obtainEmptyMsg() -> String {
        return NSLocalizedString("ComicsEmptyTableMessage", comment: "ComicsEmptyTableMessage")
    }
    
    
    //MARK: - SEARCH PLACEHOLDER
    override func obtainSearchPlaceholder() -> String {
        return NSLocalizedString("ComicsSearchPlaceholder", comment: "ComicsSearchPlaceholder")
    }
    
    
    //MARK: - ATTRIBUTION TEXT
    override func obtainAttributionText() -> String {
        return comicsModel?.attributionText ?? ""
    }
    
}
