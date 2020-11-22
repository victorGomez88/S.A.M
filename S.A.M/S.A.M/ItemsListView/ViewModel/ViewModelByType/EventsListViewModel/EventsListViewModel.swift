//
//  EventsListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class EventsListViewModel: ItemsListViewModel {
    
    private var eventModel : EventsModel?
    private var eventsList = [EventModel]()
    
    public func getEventsListData(_ inputModel: EventsInputModel?) -> Observable<EventsModel> {
        return EventsService().getEventsList(inputModel: inputModel)
    }
    
    override func obtainDetailVC(with index: Int) -> UIViewController{
        let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
        let vc : EventDetailViewController = storyboard.instantiateViewController(withIdentifier: "EventDetailViewControllerId") as! EventDetailViewController
        vc.eventId = eventsList[index].id
        return vc
    }
    
    //MARK: - GET DATA FROM SERVICE
    override func getData(searchedText: String? = "", offset: Int? = 0, fromSearch: Bool? = false, onNext: (@escaping() -> Void)) {
        let inputModel = EventsInputModel.init(nameStartsWith: searchedText, offset: offset)
        
        return getEventsListData(inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                
                self.eventModel = modelData
                self.offset = self.eventModel?.data.offset
                
                if fromSearch ?? false {
                    self.eventsList = modelData.data.eventsList
                } else {
                    self.eventsList.append(contentsOf: modelData.data.eventsList)
                }
                
                onNext()

            }, onError: { error in
                let alert = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    self.view?.navigationController?.popViewController(animated: true)
                }))
                
                self.view?.present(alert, animated: true)
            }).disposed(by: disposeBag)
    
    }
    
    //MARK: - TITLE VIEWCONTROLLER
    override func obtainTitle() -> String {
        return NSLocalizedString("Events", comment: "Events")
    }

    //MARK: - CELL CONFIGURATION
    override func obtainCellName() -> String {
        return "EventCell"
    }
    
    override func obtainCellHeight() -> CGFloat {
        return 100
    }
    
    override func obtainCellCount() -> Int {
        return self.eventsList.count
    }
    
    override func obtainCell(with tableView: UITableView, index: Int, searchedText: String?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: obtainCellName()) as! EventCell
        
        cell.selectionStyle = .none
        if let url = URL(string: eventsList[index].imageURL.path + "." +  eventsList[index].imageURL.thumbnailExtension) {
            cell.leftImageView.af.setImage(withURL:url, placeholderImage: UIImage(named:"placeholder"))
        }

        cell.lblTitle.text = eventsList[index].title
        
        return cell
    }
    
    override func hasMoreData(index: Int)  -> Bool {
    
        if let eventsModel = self.eventModel {
            return index == (eventsList.count - 1) && index < (eventsModel.data.total - 1)
        }
        
        return false
    }
    
    //MARK: -EMPTY STATE
    override func showEmptyBackground() -> Bool {
        return eventsList.count == 0
    }
    
    override func obtainEmptyMsg() -> String {
        return NSLocalizedString("EventsEmptyTableMessage", comment: "EventsEmptyTableMessage")
    }
    
    
    //MARK: - SEARCH PLACEHOLDER
    override func obtainSearchPlaceholder() -> String {
        return NSLocalizedString("EventsSearchPlaceholder", comment: "EventsSearchPlaceholder")
    }
    
    
    //MARK: - ATTRIBUTION TEXT
    override func obtainAttributionText() -> String {
        return eventModel?.attributionText ?? ""
    }
}
