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
    
//    static let sharedInstance = EventsService()
//
//    public var eventsList: [EventsResult] = []
//    private var eventModel : EventsOutputModel?
//
//    //MARK: - /events
//    /// Obtain events list
//    func getEventsList(inputModel: EventsInputModel?, moreData: Bool) -> Observable<EventsOutputModel>{
//
//        Observable.create { observer in
//
//            if self.eventsList.count > 0 && !moreData{
//                if let eventModel = self.eventModel {
//                    observer.onNext(eventModel)
//                } else {
//                    print("Error with character model")
//                }
//            } else {
//
//                BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
//                                                url: APIConstants.Endpoints.Events.eventsList) {
//                    dataResponse in
//                    do {
//                        let decoder = JSONDecoder()
//                        self.eventModel = try decoder.decode(EventsOutputModel.self, from: dataResponse)
//
//                        guard let eventModel = self.eventModel else { return }
//                        self.eventsList.append(contentsOf: eventModel.data.eventsList)
//
//                        observer.onNext(eventModel)
//                    } catch let error {
//                        observer.onError(error)
//                        print("Error message: " + error.localizedDescription)
//                    }
//
//                    observer.onCompleted()
//                } failure: { (error) in
//                    print(error)
//                }
//
//            }
//
//            return Disposables.create {}
//        }
//
//    }
//
//    //MARK: - /events/{eventId}
//    /// Obtain specific events
//    /// - Parameter eventID: desired event id
//    func getEvent(with eventID: Int) {
//        BaseServiceManager.doGetRequest(params: nil,
//                                        url: String(format:APIConstants.Endpoints.Events.event, String(eventID)))
//        { success in
//
//        } failure: { (error) in
//            print(error)
//        }
//    }

}
