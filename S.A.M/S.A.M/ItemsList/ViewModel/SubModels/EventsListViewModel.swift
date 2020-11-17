//
//  EventsListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class EventsListViewModel : ItemsListViewModel {
    
    private var eventsService = EventsService.sharedInstance
    private var events = [EventsResult]()
    private var eventModel : EventsOutputModel?
    private var moreData : Bool = false
    
    func getEventsListData(with inputModel: EventsInputModel?) -> Observable<EventsOutputModel> {
        return eventsService.getEventsList(inputModel: inputModel, moreData: moreData)
    }
    
    override func getData(with inputModel: Any?, onNextCompletion: (@escaping() -> Void)) {
        return self.getEventsListData(with: nil)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.eventModel = modelData
                self.events = self.eventsService.eventsList
                onNextCompletion()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func getMoreData(onNextCompletion:(@escaping() -> Void)) {
        
        let inputModel = EventsInputModel.init(offset: (self.eventModel?.data.offset ?? 0) + 20)
        
        return self.getEventsListData(with: inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.eventModel = modelData
                self.events = self.eventsService.eventsList
                onNextCompletion()
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    override func haveMoreData(index: Int) -> Bool {
        
        guard let eventModel = self.eventModel else { return false }
        
        moreData = eventModel.data.offset < eventModel.data.total
        
        return index == eventModel.data.offset + (eventModel.data.count - 1) && index < eventModel.data.total
    }
    
    override func getCountItems() -> Int {
        return events.count
    }
    
    override func getImageName(index: Int) -> String {
        return events[index].thumbnail.path + "." + events[index].thumbnail.thumbnailExtension
    }
    
    override func getItemName(index: Int) -> String {
        return events[index].title
    }
}
