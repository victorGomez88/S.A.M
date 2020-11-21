//
//  EventDetailViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit
import RxSwift

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var imgEventImage: UIImageView!
    
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblEventDescription: UILabel!
    
    @IBOutlet weak var viewExternalLinks: ExternalLinksView!
    
    @IBOutlet weak var viewStackNavigationButtons: UIStackView!
    
    @IBOutlet weak var viewPreviousEventContainer: UIView!
    @IBOutlet weak var btnPreviousEventButton: UIButton!
    
    @IBOutlet weak var viewNextEventContainer: UIView!
    @IBOutlet weak var btnNextEventButton: UIButton!
    
    @IBOutlet weak var lblAttributionText: UILabel!
    
    private var viewModel = EventDetailViewModel()
    var disposeBag = DisposeBag()
    
    public var eventId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Details", comment: "Details")
        self.closeButton()
        viewModel.bind(view: self)
        getEventData()
        
    }
    
    override func closeButtonAction(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
   
    private func getEventData() {
        return viewModel.getComicData(eventId ?? 0)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe { (eventData) in
                self.viewModel.event = eventData
                self.updateView(eventData: eventData)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func updateView(eventData: EventDetailModel) {
        guard let event = eventData.data.eventDetail.first else { return }
        
        //MARK: - Image
        if let url = URL(string: event.imageURL.path + "." +  event.imageURL.thumbnailExtension) {
            imgEventImage.af.setImage(withURL:url, placeholderImage: UIImage(named:"placeholder"))
        }
        
        //MARK: - Name
        lblEventTitle.isHidden = event.title.isEmpty
        lblEventTitle.text = event.title
        
        //MARK: - Description
        if let eventDescription = event.eventDescription {
            lblEventDescription.isHidden = eventDescription.isEmpty
            lblEventDescription.text = eventDescription
        }
        
        //MARK: - Navigations
        //Previous
        if let previous = event.previous {
            viewPreviousEventContainer.isHidden = previous.name.isEmpty || previous.resourceURI.isEmpty
            btnPreviousEventButton.setTitle("< " + previous.name, for: .normal)
            btnPreviousEventButton.isUserInteractionEnabled = !previous.name.isEmpty || !previous.resourceURI.isEmpty
        }
        //Next
        if let next = event.next {
            viewNextEventContainer.isHidden = next.name.isEmpty || next.resourceURI.isEmpty
            btnNextEventButton.setTitle(next.name + " >", for: .normal)
            btnNextEventButton.isUserInteractionEnabled = !next.name.isEmpty || !next.resourceURI.isEmpty
        }
        
        //MARK: - ExternalLinks
        event.urls.forEach { url in
            if url.type == "detail" && !url.url.isEmpty {
                viewExternalLinks.setLeftLink(with: NSLocalizedString("DetailsLink", comment: "DetailsLink"), urlPath: url.url)
            }
            
            //If url contains the path /comics/ show the link to the web
            if url.type == "comiclink" && !url.url.isEmpty && url.url.contains("/comics/") {
                viewExternalLinks.setRightLink(with: String(format:NSLocalizedString("ComicsLink", comment: "ComicsLink"), event.title), urlPath: url.url)
            }
        }
        
        viewExternalLinks.isHidden = viewExternalLinks.isComponenteHidden()
        
        //MARK: - Attributtion
        lblAttributionText.text = eventData.attributionText
    }
    
    
    @IBAction func btnPreviousEventAction(_ sender: Any) {
        viewModel.navigateToPreviousEvent()
    }
    
    @IBAction func btnNextEventAction(_ sender: Any) {
        viewModel.navigateToNextEvent()
    }
    
    
}
