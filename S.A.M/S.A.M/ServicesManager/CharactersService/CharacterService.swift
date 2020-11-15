//
//  CharacterService.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class CharacterService {
    
    //MARK: - /characters
    /// Obtain list of characters
    func getCharactersList(inputModel: CharactersInputModel?) {
        
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(), url: APIConstants.Endpoints.Characters.charactersList) { dataResponse in
            do {
                let decoder = JSONDecoder()
                let characterList = try decoder.decode(CharactersModel.self, from: dataResponse)
                let listCharacters = characterList.data.characterList
                
                print(listCharacters)
            } catch let error {
                print("Error message: " + error.localizedDescription)
            }
            
        } failure: { error in
            
        }
    }
    
    
    //MARK: - /characters/{characterId}
    /// Obtain specific character
    /// - Parameter characterID: desired character id
    func getCharacter(with characterID: Int) {
        
        BaseServiceManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Characters.character, String(characterID))) {
            dataResponse in
            do {
                let decoder = JSONDecoder()
                let characterList = try decoder.decode(CharactersModel.self, from: dataResponse)
                let character = characterList.data.characterList[0]
                
                print(character)
            } catch let error {
                print("Error message: " + error.localizedDescription)
            }
            
        } failure: { (error) in
            print(error)
        }
    }
    
    //MARK: - /characters/{characterId}/comics
    /// Obtain comics from a character
    /// - Parameter characterID: desired character id to obtain his/her comics
    func getCharacterComicsList(with characterID: Int) {
        
        BaseServiceManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Characters.characterComicsList, String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /characters/{characterId}/events
    /// Obtain events from a character
    /// - Parameter characterID: desired character id to obtain his/her events
    func getCharacterEventsList(with characterID: Int) {
        
        BaseServiceManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Characters.characterEventsList, String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /characters/{characterId}/series
    /// Obtain series from a character
    /// - Parameter characterID: desired character id to obtain his/her series
    func getCharacterSeriesList(with characterID: Int) {
        
        BaseServiceManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Characters.characterSeriesList,String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /characters/{characterId}/stories
    /// Obtain stories from a character
    /// - Parameter characterID: desired character id to obtain his/her stories
    func getCharacterStoriesList(with characterID: Int) {
        
        BaseServiceManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Characters.characterStoriesList, String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
}
