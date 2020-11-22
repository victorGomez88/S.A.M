//
//  SerieDetailViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class SerieDetailViewModel {
    
    private weak var view: SerieDetailViewController?
    
    var serie: SerieDetailModel?

    func bind(view: SerieDetailViewController) {
        self.view = view
    }
    
    func getSerieData(_ serietId: Int) -> Observable<SerieDetailModel> {
        return SeriesService().getSerie(with: serietId)
    }
    
    func obtainImageUrl(serie: DetailSerieModel) -> String{
        return serie.imageURL.path + "." +  serie.imageURL.thumbnailExtension
    }
    
    func obtainWriters(serie: DetailSerieModel) -> String {
        var writers: [String] = []
        
        serie.serieCreators.creators.forEach { creator in
            if creator.role.contains("writer") {
                writers.append(creator.name)
            }
        }
        
        return writers.joined(separator: ", ")
    }
    
    func obtainArtists(serie: DetailSerieModel) -> String {
        var artirsts: [String] = []
        
        serie.serieCreators.creators.forEach { creator in
            if creator.role.contains("penciller") || creator.role.contains("cover"){
                artirsts.append(creator.name)
            }
        }
        
        return artirsts.joined(separator: ", ")
    }
    
    func obtainEditors(serie: DetailSerieModel) -> String {
        var editors: [String] = []
        
        serie.serieCreators.creators.forEach { creator in
            if creator.role.contains("editor") {
                editors.append(creator.name)
            }
        }
        
        return editors.joined(separator: ", ")
    }
    
    func navigateTo(next: Bool) {
       
        if ((self.serie?.data.serieDetail.first?.next?.resourceURI) != nil) {
            if let view = view, let navController = view.navigationController {
                UIView.transition(with: navController.view, duration: 0.75, options: next ? .transitionFlipFromRight : .transitionFlipFromLeft) {
                    let serieId = String(self.serie?.data.serieDetail.first?.previous?.resourceURI.split(separator: "/").last ?? "")
                    let storyboard = UIStoryboard(name: "SerieDetail", bundle: nil)
                    let vc : SerieDetailViewController = storyboard.instantiateViewController(withIdentifier: "SerieDetailViewControllerId") as! SerieDetailViewController
                    vc.serieId = Int(serieId)
                    navController.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
}
