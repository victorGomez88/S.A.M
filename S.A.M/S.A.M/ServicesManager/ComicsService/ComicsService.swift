//
//  ComicsService.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class ComicsService {
    
    //MARK: - /comics
    /// Obtain comics list
    func getComicsList(inputModel: ComicsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: APIConstants.Endpoints.Comics.comicsList) {
            dataResponse in
            do {
                let decoder = JSONDecoder()
                let comicsList = try decoder.decode(ComicsOutputModel.self, from: dataResponse)
                
                print(comicsList)
            } catch let error {
                print("Error message: " + error.localizedDescription)
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    //MARK: - /comics/{comicId}
    /// Obtain specific comic
    /// - Parameter comicID: desired comic id
    func getComic(with comicID: Int) {
        
    }
    
    
    //MARK: - /comics/{comicId}/characters
    /// Obtain characters of specific comic
    /// - Parameter comicID: desired comic id to obtain its characters
    func getComicCharactersList(with comicID: Int) {
        
    }
    
    
    //MARK: - /comics/{comicId}/creators
    /// Obtain creators of specific comic
    /// - Parameter comicID: desired comic id to obtain its creators
    func getComicCreatorsList(with comicID: Int) {
        
    }
    
    
    //MARK: - /comics/{comicId}/events
    /// Obtain events of specific comic
    /// - Parameter comicID: desired comic id to obtain its events
    func getComicEventsList(with comicID: Int) {
        
    }
    
    
    //MARK: - /comics/{comicId}/stories
    /// Obtain stories of specific comic
    /// - Parameter comicID: desired comic id to obtain its stories
    func getComicStoriesList(with comicID: Int) {
        
    }

}
