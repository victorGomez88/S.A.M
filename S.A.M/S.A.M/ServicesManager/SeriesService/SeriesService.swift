//
//  SeriesService.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class SeriesService {
    //MARK: - /series
    /// Obtain series list
    func getSeriesList(inputModel: SeriesInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: APIConstants.Endpoints.Series.seriesList) {
            dataResponse in
            do {
                let decoder = JSONDecoder()
                let seriesList = try decoder.decode(SeriesOutputModel.self, from: dataResponse)

                print(seriesList)
            } catch let error {
                print("Error message: " + error.localizedDescription)
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    //MARK: - /series/{serieId}
    /// Obtain specific serie
    /// - Parameter serieID: desired serie id
    func getSerie(with serieID: Int) {
        BaseServiceManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Series.serie, String(serieID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /series/{serieId}/characters
    /// Obtain characters of specific serie
    /// - Parameter serieID: desired serie id to obtain its characters
    func getSerieCharactersList(with serieID: Int, inputModel: CharactersInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Series.serieCharactersList, String(serieID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /series/{serieId}/comics
    /// Obtain comics of specific serie
    /// - Parameter serieID: desired serie id to obtain its comics
    func getSerieComicsList(with serieID: Int, inputModel: ComicsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Series.serieComicsList, String(serieID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /series/{serieId}/creators
    /// Obtain creators of specific serie
    /// - Parameter serieID: desired serie id to obtain its creators
    func getSerieCreatorsList(with serieID: Int, inputModel: CreatorsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Series.serieCreatorsList, String(serieID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /series/{serieId}/events
    /// Obtain events of specific serie
    /// - Parameter serieID: desired serie id to obtain its events
    func getSerieEventsList(with serieID: Int, inputModel: EventsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Series.serieEventsList, String(serieID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /series/{serieId}/stories
    /// Obtain stories of specific serie
    /// - Parameter serieID: desired serie id to obtain its stories
    func getSerieStoriesList(with serieID: Int, inputModel: StoriesInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Series.serieStoriesList, String(serieID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
}
