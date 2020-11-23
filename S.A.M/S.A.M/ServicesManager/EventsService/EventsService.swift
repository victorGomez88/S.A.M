//
//  EventsService.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class EventsService {

    //MARK: - /events
    /// Obtain events list
    func getEventsList(inputModel: EventsInputModel?) -> Observable<EventsModel>{

        Observable.create { observer in

                BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                                url: APIConstants.Endpoints.Events.eventsList) {
                    dataResponse in
                    do {
                        let decoder = JSONDecoder()
                        let eventModel = try decoder.decode(EventsModel.self, from: dataResponse)
                        observer.onNext(eventModel)
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

    //MARK: - /events/{eventId}
    /// Obtain specific events
    /// - Parameter eventID: desired event id
    func getEvent(with eventID: Int) -> Observable<EventDetailModel>{
        Observable.create { observer in
            BaseServiceManager.doGetRequest(params: nil,
                                            url: String(format:APIConstants.Endpoints.Events.event, String(eventID))) {
            dataResponse in
            do {
                let decoder = JSONDecoder()
                let eventModel = try decoder.decode(EventDetailModel.self, from: dataResponse)
                observer.onNext(eventModel)
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

}
