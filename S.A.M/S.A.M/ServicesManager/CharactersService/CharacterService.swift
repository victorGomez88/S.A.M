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
    func getCharactersList(inputModel: CharactersInputModel?) -> Observable<CharactersModel>{
        
        return Observable.create { observer in
            
            BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(), url: APIConstants.Endpoints.Characters.charactersList, success: {
                dataResponse in
                do {
                    let decoder = JSONDecoder()
                    let charactersModel = try decoder.decode(CharactersModel.self, from: dataResponse)
                    observer.onNext(charactersModel)
                    
                } catch let error {
                    print("Error message: " + error.localizedDescription)
                    observer.onError(error)
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
    func getCharacter(with characterID: Int) -> Observable<CharacterDetailModel> {
        
        Observable.create { observer in
            
            BaseServiceManager.doGetRequest(params: nil,
                                            url: String(format:APIConstants.Endpoints.Characters.character, String(characterID))) {
                dataResponse in
                do {
                    let decoder = JSONDecoder()
                    let character = try decoder.decode(CharacterDetailModel.self, from: dataResponse)
                   
                    observer.onNext(character)
                } catch let error {
                    print("Error message: " + error.localizedDescription)
                    observer.onError(error)
                }
                
            } failure: { (error) in
                print(error)
            }
            
            return Disposables.create {
            }
        }
        
    }
    
}
