//
//  ComicDetailViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit
import RxSwift

class ComicDetailViewController: UIViewController {
    
    @IBOutlet weak var comicImageView: UIImageView!
    
    @IBOutlet weak var lblComicTitle: UILabel!
    @IBOutlet weak var lblPagesNumber: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblSummary: UILabel!
    
    @IBOutlet weak var viewWriterContainer: UIView!
    @IBOutlet weak var lblWritenBy: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    
    @IBOutlet weak var viewArtContainer: UIView!
    @IBOutlet weak var lblArtBy: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    
    @IBOutlet weak var externalLinks: ExternalLinksView!
    
    @IBOutlet weak var lblAttribution: UILabel!
    
    private var viewModel = ComicDetailViewModel()
    var disposeBag = DisposeBag()
    
    public var comicId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()

        self.title = NSLocalizedString("Details", comment: "Details")
        self.closeButton()
        
        viewModel.bind(view: self)
        getComicData()
    }
    
    override func closeButtonAction(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func getComicData() {
        return viewModel.getComicData(comicId ?? 0)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe { (comicData) in
                self.updateView(comicData: comicData)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func updateView(comicData: ComicDetailModel) {
        
        guard let comic = comicData.data.comicDetail.first else { return }
        
        //MARK: - Image
        if let url = URL(string: viewModel.obtainImageUrl(comic: comic)) {
            comicImageView.af.setImage(withURL:url)
        }
        
        //MARK: - Name
        lblComicTitle.isHidden = comic.title.isEmpty
        lblComicTitle.text = comic.title
        
        //MARK: - Pages
        lblPagesNumber.isHidden = comic.pageCount == 0
        lblPagesNumber.text = String(format:"Pages: %d",comic.pageCount)
        
        //MARK: - Release Date
        lblReleaseDate.isHidden = viewModel.obtainReleaseDate(comic: comic).isEmpty
        lblReleaseDate.text = "Release: \(viewModel.obtainReleaseDate(comic: comic))"
    
        //MARK: - Price
        lblPrice.isHidden = viewModel.obtainPrice(comic: comic).isEmpty
        lblPrice.text = "Price: \(viewModel.obtainPrice(comic: comic))"
        
        //MARK: - Description
        if let description = comic.comicDescription {
            lblSummary.isHidden = description.isEmpty
            lblSummary.text = description.replacingOccurrences(of: "<br>", with: "\r")
        } else {
            lblSummary.isHidden = true
        }
        
        //MARK: - Writers
        viewWriterContainer.isHidden = viewModel.obtainWriters(comic: comic).isEmpty
        lblWritenBy.text = "Writer: "
        lblWriter.text = viewModel.obtainWriters(comic: comic)
        
        //MARK: - Art
        viewArtContainer.isHidden = viewModel.obtainArtists(comic: comic).isEmpty
        lblArtBy.text = "Artirst: "
        lblArtist.text = viewModel.obtainArtists(comic: comic)
        
        //MARK: - ExternalLinks
        comic.urls.forEach { url in
            if url.type == "detail" && !url.url.isEmpty {
                externalLinks.setLeftLink(with: NSLocalizedString("DetailsLink", comment: "DetailsLink"), urlPath: url.url)
            }
        }
        
        externalLinks.isHidden = externalLinks.isComponenteHidden()
        
        //Attributtion
        lblAttribution.text = comicData.attributionText
    }
}
