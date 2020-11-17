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
    
    static let sharedInstance = CharacterService()
    
    //MARK: - /characters
    /// Obtain list of characters
    func getCharactersList(inputModel: CharactersInputModel?) -> Observable<CharactersModel>{
        
        return Observable.create { observer in
            
            BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(), url: APIConstants.Endpoints.Characters.charactersList, success: {
                dataResponse in
                do {
                    let decoder = JSONDecoder()
                    let charactersModel = try decoder.decode(CharactersModel.self, from: dataResponse)
                    observer.onNext(charactersModel)
                    
                } catch let error {
                    observer.onError(error)
                    print("Error message: " + error.localizedDescription)
                }
                
                observer.onCompleted()
            }, failure: { error in
                print(error)
            })
            
            return Disposables.create {
                
            }
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
                print(characterList)
            } catch let error {
                print("Error message: " + error.localizedDescription)
            }
            
        } failure: { (error) in
            print(error)
        }
    }
    
}
