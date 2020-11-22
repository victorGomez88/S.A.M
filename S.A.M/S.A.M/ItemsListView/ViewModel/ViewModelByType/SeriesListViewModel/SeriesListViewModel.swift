//
//  SeriesListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class SeriesListViewModel: ItemsListViewModel {
    
    private var serieModel : SeriesModel?
    private var seriesList = [SerieModel]()
    
    public func getSeriesListData(_ inputModel: SeriesInputModel?) -> Observable<SeriesModel> {
        return SeriesService().getSeriesList(inputModel: inputModel)
    }
    
    override func obtainDetailVC(with index: Int) -> UIViewController{
        let storyboard = UIStoryboard(name: "SerieDetail", bundle: nil)
        let vc : SerieDetailViewController = storyboard.instantiateViewController(withIdentifier: "SerieDetailViewControllerId") as! SerieDetailViewController
        vc.serieId = seriesList[index].id
        return vc
    }
    
    //MARK: - GET DATA FROM SERVICE
    override func getData(searchedText: String? = "", offset: Int? = 0, fromSearch: Bool? = false, onNext: (@escaping() -> Void)) {
        let inputModel = SeriesInputModel.init(titleStartsWith: searchedText, offset: offset)
        
        return getSeriesListData(inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                
                self.serieModel = modelData
                self.offset = self.serieModel?.data.offset
                
                if fromSearch ?? false {
                    self.seriesList = modelData.data.seriesList
                } else {
                    self.seriesList.append(contentsOf: modelData.data.seriesList)
                }
                
                onNext()

            }, onError: { error in
                let alert = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    self.view?.navigationController?.popViewController(animated: true)
                }))
                
                self.view?.present(alert, animated: true)
            }).disposed(by: disposeBag)
    
    }
    
    //MARK: - TITLE VIEWCONTROLLER
    override func obtainTitle() -> String {
        return NSLocalizedString("Series", comment: "Series")
    }

    //MARK: - CELL CONFIGURATION
    override func obtainCellName() -> String {
        return "SeriesCell"
    }
    
    override func obtainCellHeight() -> CGFloat {
        return 100
    }
    
    override func obtainCellCount() -> Int {
        return self.seriesList.count
    }
    
    override func obtainCell(with tableView: UITableView, index: Int, searchedText: String?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: obtainCellName()) as! SeriesCell
        
        cell.selectionStyle = .none
        if let url = URL(string: seriesList[index].imageURL.path + "." +  seriesList[index].imageURL.thumbnailExtension) {
            cell.imgLeftImageView.af.setImage(withURL:url, placeholderImage: UIImage(named:"placeholder"))
        }

        cell.lblTitle.text = seriesList[index].title
        
        return cell
    }
    
    override func hasMoreData(index: Int)  -> Bool {
    
        if let serieModel = self.serieModel {
            return index == (seriesList.count - 1) && index < (serieModel.data.total - 1)
        }
        
        return false
    }
    
    //MARK: -EMPTY STATE
    override func showEmptyBackground() -> Bool {
        return seriesList.count == 0
    }
    
    override func obtainEmptyMsg() -> String {
        return NSLocalizedString("SeriesEmptyTableMessage", comment: "SeriesEmptyTableMessage")
    }
    
    
    //MARK: - SEARCH PLACEHOLDER
    override func obtainSearchPlaceholder() -> String {
        return NSLocalizedString("SeriesSearchPlaceholder", comment: "SeriesSearchPlaceholder")
    }
    
    
    //MARK: - ATTRIBUTION TEXT
    override func obtainAttributionText() -> String {
        return serieModel?.attributionText ?? ""
    }
}
