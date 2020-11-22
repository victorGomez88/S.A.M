//
//  SeriesService.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class SeriesService {

    //MARK: - /series
    /// Obtain series list
    func getSeriesList(inputModel: SeriesInputModel?) -> Observable<SeriesModel>{
        
        Observable.create { observer in
            
            BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                            url: APIConstants.Endpoints.Series.seriesList) {
                dataResponse in
                do {
                    let decoder = JSONDecoder()
                    let serieModel = try decoder.decode(SeriesModel.self, from: dataResponse)
                    
                    observer.onNext(serieModel)
                } catch let error {
                    observer.onError(error)
                    print("Error message: " + error.localizedDescription)
                }
                
                observer.onCompleted()
            } failure: { (error) in
                print(error)
            }
            
            return Disposables.create {}
        }
    }
    
    //MARK: - /series/{serieId}
    /// Obtain specific serie
    /// - Parameter serieID: desired serie id
    func getSerie(with serieID: Int)  -> Observable<SerieDetailModel>{
        
        Observable.create { observer in
            BaseServiceManager.doGetRequest(params: nil,
                                            url: String(format:APIConstants.Endpoints.Series.serie, String(serieID)))
            { dataResponse in
                do {
                    let decoder = JSONDecoder()
                    let serieDetailModel = try decoder.decode(SerieDetailModel.self, from: dataResponse)
                    
                    observer.onNext(serieDetailModel)
                } catch let error {
                    observer.onError(error)
                    print("Error message: " + error.localizedDescription)
                }
                
                observer.onCompleted()
                
            } failure: { (error) in
                print(error)
            }
            
            return Disposables.create {}
        }
    }
}
