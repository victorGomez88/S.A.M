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
    
    static let sharedInstance = CreatorsService()
    
    public var creatorsList: [CreatorsResult] = []
    private var creatorModel : CreatorsOutputModel?
    
    //MARK: - /creators
    /// Obtain creators list
    func getCreatorsList(inputModel: CreatorsInputModel?, moreData: Bool) -> Observable<CreatorsOutputModel> {
        
        Observable.create { observer in
            
            if self.creatorsList.count > 0 && !moreData{
                if let creatorModel = self.creatorModel {
                    observer.onNext(creatorModel)
                } else {
                    print("Error with character model")
                }
            } else {
                
                BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                                url: APIConstants.Endpoints.Creators.creatorsList) {
                    dataResponse in
                    do {
                        let decoder = JSONDecoder()
                        
                        self.creatorModel = try decoder.decode(CreatorsOutputModel.self, from: dataResponse)
                        
                        guard let creatorModel = self.creatorModel else { return }
                        self.creatorsList.append(contentsOf: creatorModel.data.creatorsList)
                        
                        observer.onNext(creatorModel)
                        
                    } catch let error {
                        observer.onError(error)
                        print("Error message: " + error.localizedDescription)
                    }
                    
                    observer.onCompleted()
                } failure: { (error) in
                    print(error)
                }
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
    
    
    //MARK: - /creators/{creatorId}/comics
    /// Obtain comics of specific creator
    /// - Parameter creatorID: desired creator id to obtain his/her comics
    func getCreatorComicsList(with creatorID: Int, inputModel: ComicsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Creators.creatorComicsList, String(creatorID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /creators/{creatorId}/events
    /// Obtain events of specific creator
    /// - Parameter creatorID: desired creator id to obtain his/her events
    func getCreatorEventsList(with creatorID: Int, inputModel: EventsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Creators.creatorEventsList, String(creatorID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /creators/{creatorId}/series
    /// Obtain series of specific creator
    /// - Parameter creatorID: desired creator id to obtain his/her series
    func getCreatorSeriesList(with creatorID: Int, inputModel: SeriesInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Creators.creatorSeriesList, String(creatorID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /creators/{creatorId}/stories
    /// Obtain stories of specific creator
    /// - Parameter creatorID: desired creator id to obtain its stories
    func getCreatorStoriesList(with creatorID: Int, inputModel: StoriesInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Creators.creatorStoriesList, String(creatorID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
}
