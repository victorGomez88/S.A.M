//
//  CreatorsService.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class CreatorsService {
    //MARK: - /creators
    /// Obtain creators list
    func getCreatorsList(inputModel: CreatorsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: APIConstants.Endpoints.Creators.creatorsList) {
            dataResponse in
            do {
                let decoder = JSONDecoder()
                let creatorsList = try decoder.decode(CreatorsOutputModel.self, from: dataResponse)
                
                print(creatorsList)
            } catch let error {
                print("Error message: " + error.localizedDescription)
            }
        } failure: { (error) in
            print(error)
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
