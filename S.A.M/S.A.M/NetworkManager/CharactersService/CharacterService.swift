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
    
    func getCharactersList() {
        
        BaseNetworkManager.doGetRequest(params: nil, url: APIConstants.Endpoints.Characters.charactersList) { dataResponse in
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
    
    func getCharacter(with characterID: Int) {
        
        BaseNetworkManager.doGetRequest(params: nil,
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
    
    func getCharacterComicsList(with characterID: Int) {
        
        BaseNetworkManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Characters.characterComicsList, String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    func getCharacterEventsList(with characterID: Int) {
        
        BaseNetworkManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Characters.characterEventsList, String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    func getCharacterSeriesList(with characterID: Int) {
        
        BaseNetworkManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Characters.characterSeriesList,String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    func getCharacterStoriesList(with characterID: Int) {
        
        BaseNetworkManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Characters.characterStoriesList, String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
}
