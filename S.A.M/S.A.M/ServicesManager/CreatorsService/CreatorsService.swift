//
//  CreatorsService.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class CreatorsService {
    
    //MARK: - /creators
    /// Obtain creators list
    func getCreatorsList(inputModel: CreatorsInputModel?) -> Observable<CreatorsModel> {
        
        Observable.create { observer in
            
            BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                            url: APIConstants.Endpoints.Creators.creatorsList) {
                dataResponse in
                do {
                    let decoder = JSONDecoder()
                    let creatorModel = try decoder.decode(CreatorsModel.self, from: dataResponse)
                    observer.onNext(creatorModel)
                    
                } catch let error {
                    observer.onError(error)
                    print("Error message: " + error.localizedDescription)
                }
                
                observer.onCompleted()
            } failure: { (error) in
                print(error)
            }
            return Disposables.create{}
        }
    }
    
    //MARK: - /creators/{creatorId}
    /// Obtain specific creators
    /// - Parameter creatorID: desired creator id
    func getCreator(with creatorID: Int) {
        BaseServiceManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Creators.creator, String(creatorID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
}
