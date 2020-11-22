//
//  SerieDetailViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 22/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit
import RxSwift

class SerieDetailViewController: UIViewController {
    
    @IBOutlet weak var imgSerieImage: UIImageView!
    
    @IBOutlet weak var lblTitleSerie: UILabel!
    @IBOutlet weak var lblDescriptionSerie: UILabel!
    @IBOutlet weak var viewExternalLinks: ExternalLinksView!
    
    //CREATORS
    @IBOutlet weak var viewWriterContainer: UIView!
    @IBOutlet weak var lblWriterBy: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    
    @IBOutlet weak var viewArtistContainer: UIView!
    @IBOutlet weak var lblArtBy: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    
    @IBOutlet weak var viewEditorContainer: UIView!
    @IBOutlet weak var lblEditedBy: UILabel!
    @IBOutlet weak var lblEditor: UILabel!
    
    
    //NAVIGATIONS + ATTRIBUTION TEXT
    @IBOutlet weak var stackNavigations: UIStackView!
    
    @IBOutlet weak var viewPreviousContainer: UIView!
    @IBOutlet weak var btnPreviousSerie: UIButton!
    
    @IBOutlet weak var viewNextContainer: UIView!
    @IBOutlet weak var btnNextSerie: UIButton!
    
    @IBOutlet weak var lblAttributionText: UILabel!
    
    
    private var viewModel = SerieDetailViewModel()
    var disposeBag = DisposeBag()
    
    public var serieId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Details", comment: "Details")
        self.closeButton()
        viewModel.bind(view: self)
        getSerieData()
    }
    
    override func closeButtonAction(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func getSerieData() {
        return viewModel.getSerieData(serieId ?? 0)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe { (serieData) in
                self.viewModel.serie = serieData
                self.updateView(serieData: serieData)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func updateView(serieData: SerieDetailModel) {
        
        guard let serie = serieData.data.serieDetail.first else { return }
        
        //MARK: - Image
        if let url = URL(string: viewModel.obtainImageUrl(serie: serie)) {
            imgSerieImage.af.setImage(withURL:url, placeholderImage: UIImage(named:"placeholder"))
        }
        
        //MARK: - Title
        lblTitleSerie.isHidden = serie.title.isEmpty
        lblTitleSerie.text = serie.title
        
        //MARK: - Description
        if let serieDescription = serie.serieDescription {
            lblDescriptionSerie.isHidden = serieDescription.isEmpty
            lblDescriptionSerie.text = serieDescription
        }
        
        //MARK: - Navigations
        //Previous
        if let previous = serie.previous {
            viewPreviousContainer.isHidden = previous.name.isEmpty || previous.resourceURI.isEmpty
            btnPreviousSerie.setTitle("< " + previous.name, for: .normal)
            btnPreviousSerie.isUserInteractionEnabled = !previous.name.isEmpty || !previous.resourceURI.isEmpty
        }
        //Next
        if let next = serie.next {
            viewNextContainer.isHidden = next.name.isEmpty || next.resourceURI.isEmpty
            btnNextSerie.setTitle(next.name + " >", for: .normal)
            btnNextSerie.isUserInteractionEnabled = !next.name.isEmpty || !next.resourceURI.isEmpty
        }
        
        //MARK: - Writers
        viewWriterContainer.isHidden = viewModel.obtainWriters(serie: serie).isEmpty
        lblWriterBy.text = "Writer: "
        lblWriter.text = viewModel.obtainWriters(serie: serie)
        
        //MARK: - Art
        viewArtistContainer.isHidden = viewModel.obtainArtists(serie: serie).isEmpty
        lblArtBy.text = "Artirst: "
        lblArtist.text = viewModel.obtainArtists(serie: serie)
        
        //MARK: - Editor
        viewEditorContainer.isHidden = viewModel.obtainEditors(serie: serie).isEmpty
        lblEditedBy.text = "Editors: "
        lblEditor.text = viewModel.obtainEditors(serie: serie)
        
        //MARK: - ExternalLinks
        serie.urls.forEach { url in
            if url.type == "detail" && !url.url.isEmpty {
                viewExternalLinks.setLeftLink(with: NSLocalizedString("DetailsLink", comment: "DetailsLink"), urlPath: url.url)
            }
        }
        
        viewExternalLinks.isHidden = viewExternalLinks.isComponenteHidden()
        
        //Attributtion
        lblAttributionText.text = serieData.attributionText
    }
    
    
    @IBAction func btnPreviousSerieAction(_ sender: Any) {
        viewModel.navigateTo(next: false)
    }
    
    @IBAction func btnNextSerieAction(_ sender: Any) {
        viewModel.navigateTo(next: true)
    }
}
