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
    
    public var characterList: [CharactersResult] = []
    private var characterModel : CharactersOutputModel?
    
    //MARK: - /characters
    /// Obtain list of characters
    func getCharactersList(inputModel: CharactersInputModel?, moreData: Bool) -> Observable<CharactersOutputModel>{
        
        return Observable.create { observer in
            
            if self.characterList.count > 0 && !moreData{
                if let characterModel = self.characterModel {
                    observer.onNext(characterModel)
                } else {
                    print("Error with character model")
                }
            } else {
                BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(), url: APIConstants.Endpoints.Characters.charactersList, success: {
                    dataResponse in
                    do {
                        let decoder = JSONDecoder()
                        self.characterModel = try decoder.decode(CharactersOutputModel.self, from: dataResponse)
                        
                        guard let characterModel = self.characterModel else { return }
                        self.characterList.append(contentsOf: characterModel.data.characterList)
                        observer.onNext(characterModel)

                    } catch let error {
                        observer.onError(error)
                        print("Error message: " + error.localizedDescription)
                    }
                    
                    observer.onCompleted()
                }, failure: { error in
                  print(error)
                })
            }
            
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
                let characterList = try decoder.decode(CharactersOutputModel.self, from: dataResponse)
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
    func getCharacterComicsList(with characterID: Int, inputModel: ComicsInputModel?) {
        
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Characters.characterComicsList, String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /characters/{characterId}/events
    /// Obtain events from a character
    /// - Parameter characterID: desired character id to obtain his/her events
    func getCharacterEventsList(with characterID: Int, inputModel: EventsInputModel?) {
        
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Characters.characterEventsList, String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /characters/{characterId}/series
    /// Obtain series from a character
    /// - Parameter characterID: desired character id to obtain his/her series
    func getCharacterSeriesList(with characterID: Int, inputModel: SeriesInputModel?) {
        
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Characters.characterSeriesList,String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /characters/{characterId}/stories
    /// Obtain stories from a character
    /// - Parameter characterID: desired character id to obtain his/her stories
    func getCharacterStoriesList(with characterID: Int, inputModel: StoriesInputModel?) {
        
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Characters.characterStoriesList, String(characterID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
}
