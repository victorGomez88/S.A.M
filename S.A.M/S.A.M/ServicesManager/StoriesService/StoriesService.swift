//
//  StoriesService.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class StoriesService {
    
    static let sharedInstance = StoriesService()
    
    public var storiesList: [StoriesResult] = []
    private var storyModel : StoriesOutputModel?
    
    //MARK: - /stories
    /// Obtain stories list
    func getStoriesList(inputModel: StoriesInputModel?, moreData: Bool) -> Observable<StoriesOutputModel> {
        
        Observable.create { observer in
            
            if self.storiesList.count > 0 && !moreData{
                if let storyModel = self.storyModel {
                    observer.onNext(storyModel)
                } else {
                    print("Error with character model")
                }
            } else {
                BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                                url: APIConstants.Endpoints.Stories.storiesList) {
                    dataResponse in
                    do {
                        let decoder = JSONDecoder()
                        self.storyModel = try decoder.decode(StoriesOutputModel.self, from: dataResponse)
                        
                        guard let storyModel = self.storyModel else { return }
                        self.storiesList.append(contentsOf: storyModel.data.storiesList)
                        observer.onNext(storyModel)
                    } catch let error {
                        observer.onError(error)
                        print("Error message: " + error.localizedDescription)
                    }
                    
                    observer.onCompleted()
                } failure: { (error) in
                    print(error)
                }
            }
            return Disposables.create {}
        }
        
    }
    
    //MARK: - /stories/{storyId}
    /// Obtain specific story
    /// - Parameter storyID: desired story id
    func getStory(with storyID: Int) {
        BaseServiceManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Stories.story, String(storyID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /stories/{storyId}/characters
    /// Obtain characters of specific story
    /// - Parameter storyID: desired story id to obtain its characters
    func getStoryCharactersList(with storyID: Int, inputModel: CharactersInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Stories.storyCharactersList, String(storyID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /stories/{storyId}/comics
    /// Obtain comics of specific story
    /// - Parameter storyID: desired story id to obtain its comics
    func getStoryComicsList(with storyID: Int, inputModel: ComicsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Stories.storyComicsList, String(storyID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /stories/{storyId}/creators
    /// Obtain creators of specific story
    /// - Parameter storyID: desired story id to obtain its creators
    func getStoryCreatorsList(with storyID: Int, inputModel: CreatorsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Stories.storyCreatorsList, String(storyID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /stories/{storyId}/events
    /// Obtain events of specific story
    /// - Parameter storyID: desired story id to obtain its events
    func getStoryEventsList(with storyID: Int, inputModel: EventsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Stories.storyEventsList, String(storyID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /stories/{storyId}/series
    /// Obtain series of specific story
    /// - Parameter storyID: desired story id to obtain its series
    func getStorySeriesList(with storyID: Int, inputModel: SeriesInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Stories.storySeriesList, String(storyID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
}
