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

    //MARK: - /stories
    /// Obtain stories list
    func getStoriesList(inputModel: StoriesInputModel?) -> Observable<StoriesModel> {
        
        Observable.create { observer in
            
            BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                            url: APIConstants.Endpoints.Stories.storiesList) {
                dataResponse in
                do {
                    let decoder = JSONDecoder()
                    let storyModel = try decoder.decode(StoriesModel.self, from: dataResponse)
                    observer.onNext(storyModel)
                } catch let error {
                    observer.onError(error)
                    print("Error message: " + error.localizedDescription)
                }
                
                observer.onCompleted()
            } failure: { (error) in
                print(error)
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



}
