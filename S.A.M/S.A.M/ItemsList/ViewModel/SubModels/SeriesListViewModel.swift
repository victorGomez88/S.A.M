//
//  SeriesListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class SeriesListViewModel : ItemsListViewModel {
    
    private var seriesService = SeriesService.sharedInstance
    private var series = [SeriesResult]()
    private var serieModel : SeriesOutputModel?
    private var moreData : Bool = false
    
    func getSeriesListData(with inputModel: SeriesInputModel?) -> Observable<SeriesOutputModel> {
        return seriesService.getSeriesList(inputModel: inputModel, moreData: moreData)
    }
    
    override func getData(with inputModel: Any?, onNextCompletion: (@escaping() -> Void)) {
        return self.getSeriesListData(with: nil)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.serieModel = modelData
                self.series = self.seriesService.seriesList
                onNextCompletion()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func getMoreData(onNextCompletion:(@escaping() -> Void)) {
        
        let inputModel = SeriesInputModel.init(offset: (self.serieModel?.data.offset ?? 0) + 20)
        
        return self.getSeriesListData(with: inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.serieModel = modelData
                self.series = self.seriesService.seriesList
                onNextCompletion()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func haveMoreData(index: Int) -> Bool {
        
        guard let serieModel = self.serieModel else { return false }
        
        moreData = serieModel.data.offset < serieModel.data.total
        
        return index == serieModel.data.offset + (serieModel.data.count - 1) && index < serieModel.data.total
    }
    
    override func getCountItems() -> Int {
        return series.count
    }
    
    override func getImageName(index: Int) -> String {
        return series[index].thumbnail.path + "." + series[index].thumbnail.thumbnailExtension
    }
    
    override func getItemName(index: Int) -> String {
        return series[index].title
    }
}
