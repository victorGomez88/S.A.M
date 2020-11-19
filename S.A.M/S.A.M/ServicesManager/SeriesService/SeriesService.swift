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
//    
//    static let sharedInstance = SeriesService()
//    
//    public var seriesList: [SeriesResult] = []
//    private var serieModel : SeriesOutputModel?
//    
//    //MARK: - /series
//    /// Obtain series list
//    func getSeriesList(inputModel: SeriesInputModel?, moreData: Bool) -> Observable<SeriesOutputModel>{
//        
//        Observable.create { observer in
//            
//            if self.seriesList.count > 0 && !moreData{
//                if let serieModel = self.serieModel {
//                    observer.onNext(serieModel)
//                } else {
//                    print("Error with character model")
//                }
//            } else {
//                BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
//                                                url: APIConstants.Endpoints.Series.seriesList) {
//                    dataResponse in
//                    do {
//                        let decoder = JSONDecoder()
//                        self.serieModel = try decoder.decode(SeriesOutputModel.self, from: dataResponse)
//                        
//                        guard let serieModel = self.serieModel else { return }
//                        self.seriesList.append(contentsOf: serieModel.data.seriesList)
//                        
//                        observer.onNext(serieModel)
//                    } catch let error {
//                        observer.onError(error)
//                        print("Error message: " + error.localizedDescription)
//                    }
//                    
//                    observer.onCompleted()
//                } failure: { (error) in
//                    print(error)
//                }
//            }
//            return Disposables.create {}
//        }
//        
//    }
//    
//    //MARK: - /series/{serieId}
//    /// Obtain specific serie
//    /// - Parameter serieID: desired serie id
//    func getSerie(with serieID: Int) {
//        BaseServiceManager.doGetRequest(params: nil,
//                                        url: String(format:APIConstants.Endpoints.Series.serie, String(serieID)))
//        { success in
//            
//        } failure: { (error) in
//            print(error)
//        }
//    }
}
