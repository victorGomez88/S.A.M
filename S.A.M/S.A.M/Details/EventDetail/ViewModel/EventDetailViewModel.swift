//
//  EventDetailViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class EventDetailViewModel {
    
    private weak var view: EventDetailViewController?
    
    var event: EventDetailModel?

    func bind(view: EventDetailViewController) {
        self.view = view
    }
    
    func getComicData(_ eventId: Int) -> Observable<EventDetailModel> {
        return EventsService().getEvent(with: eventId)
    }
    
    func obtainImageUrl(event: DetailEventModel) -> String{
        return event.imageURL.path + "." +  event.imageURL.thumbnailExtension
    }
    
    func navigateTo(eventId:Int) {
        let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
        let vc : EventDetailViewController = storyboard.instantiateViewController(withIdentifier: "EventDetailViewControllerId") as! EventDetailViewController
        vc.eventId = eventId
    }
    
    func navigateToPreviousEvent() {
        if ((self.event?.data.eventDetail.first?.next?.resourceURI) != nil) {
            if let view = view, let navController = view.navigationController {
                UIView.transition(with: navController.view, duration: 0.75, options: .transitionFlipFromLeft) {
                    let eventId = String(self.event?.data.eventDetail.first?.previous?.resourceURI.split(separator: "/").last ?? "")
                    
                    let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
                    let vc : EventDetailViewController = storyboard.instantiateViewController(withIdentifier: "EventDetailViewControllerId") as! EventDetailViewController
                    vc.eventId = Int(eventId)
                    
                    navController.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func navigateToNextEvent() {
        
        if ((self.event?.data.eventDetail.first?.next?.resourceURI) != nil) {
            if let view = view, let navController = view.navigationController {
                UIView.transition(with: navController.view, duration: 0.75, options: .transitionFlipFromRight) {
                    let eventId = String(self.event?.data.eventDetail.first?.next?.resourceURI.split(separator: "/").last ?? "")
                    
                    let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
                    let vc : EventDetailViewController = storyboard.instantiateViewController(withIdentifier: "EventDetailViewControllerId") as! EventDetailViewController
                    vc.eventId = Int(eventId)
                    
                    navController.pushViewController(vc, animated: true)
                }
            }
        }
        
    }
  
}
