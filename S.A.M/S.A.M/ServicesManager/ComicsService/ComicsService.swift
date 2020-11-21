//
//  ComicsService.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class ComicsService {
    
    //MARK: - /comics
    /// Obtain comics list
    func getComicsList(inputModel: ComicsInputModel?) -> Observable<ComicsModel> {
        
        return Observable.create { observer in
            
            BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                            url: APIConstants.Endpoints.Comics.comicsList) {
                dataResponse in
                do {
                    let decoder = JSONDecoder()
                    let comicsModel = try decoder.decode(ComicsModel.self, from: dataResponse)
                    observer.onNext(comicsModel)
                    
                } catch let error {
                    print("Error message: " + error.localizedDescription)
                    observer.onError(error)
                }
                
                observer.onCompleted()
            } failure: { (error) in
                print(error)
            }
            
            return Disposables.create {
            }
        }
    }
    
    //MARK: - /comics/{comicId}
    /// Obtain specific comic
    /// - Parameter comicID: desired comic id
    func getComic(with comicID: Int) -> Observable<ComicDetailModel>{
        
        return Observable.create { observer in
            BaseServiceManager.doGetRequest(params: nil,
                                            url: String(format:APIConstants.Endpoints.Comics.comic, String(comicID)))
            { dataResponse in
                do {
                    let decoder = JSONDecoder()
                    let comicDetailModel = try decoder.decode(ComicDetailModel.self, from: dataResponse)
                    observer.onNext(comicDetailModel)
                    
                } catch let error {
                    print("Error message: " + error.localizedDescription)
                    observer.onError(error)
                }
                
                observer.onCompleted()
                
            } failure: { (error) in
                print(error)
            }
            
            return Disposables.create {
            }
        }
    }
}
