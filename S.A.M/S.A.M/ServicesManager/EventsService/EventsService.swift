//
//  EventsService.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class EventsService {
    //MARK: - /events
    /// Obtain events list
    func getEventsList(inputModel: EventsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: APIConstants.Endpoints.Events.eventsList) {
            dataResponse in
            do {
                let decoder = JSONDecoder()
                let eventsList = try decoder.decode(EventsOutputModel.self, from: dataResponse)

                print(eventsList)
            } catch let error {
                print("Error message: " + error.localizedDescription)
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    //MARK: - /events/{eventId}
    /// Obtain specific events
    /// - Parameter eventID: desired event id
    func getEvent(with eventID: Int) {
        BaseServiceManager.doGetRequest(params: nil,
                                        url: String(format:APIConstants.Endpoints.Events.event, String(eventID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /events/{eventId}/characters
    /// Obtain characters of specific event
    /// - Parameter eventID: desired event id to obtain its characters
    func getEventCharactersList(with eventID: Int, inputModel: CharactersInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Events.eventCharactersList, String(eventID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /events/{eventId}/comics
    /// Obtain comics of specific event
    /// - Parameter eventID: desired event id to obtain its comics
    func getEventComicsList(with eventID: Int, inputModel: ComicsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Events.eventComicsList, String(eventID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /events/{eventId}/creators
    /// Obtain creators of specific event
    /// - Parameter eventID: desired event id to obtain its creators
    func getEventCreatorsList(with eventID: Int, inputModel: CreatorsInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Events.eventCreatorsList, String(eventID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /events/{eventId}/series
    /// Obtain series of specific event
    /// - Parameter eventID: desired event id to obtain its series
    func getEventsSeriesList(with eventID: Int, inputModel: SeriesInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Events.eventSeriesList, String(eventID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
    
    
    //MARK: - /events/{eventId}/stories
    /// Obtain stories of specific event
    /// - Parameter eventID: desired event id to obtain its stories
    func getEventStoriesList(with eventID: Int, inputModel: StoriesInputModel?) {
        BaseServiceManager.doGetRequest(params: inputModel?.obtainParamsDict(),
                                        url: String(format:APIConstants.Endpoints.Events.eventStoriesList, String(eventID)))
        { success in
            
        } failure: { (error) in
            print(error)
        }
    }
}
