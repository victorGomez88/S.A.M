//
//  ComicDetailViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class ComicDetailViewModel {
    
    private weak var view: ComicDetailViewController?

    func bind(view: ComicDetailViewController) {
        self.view = view
    }
    
    func getComicData(_ comicId: Int) -> Observable<ComicDetailModel> {
        return ComicsService().getComic(with: comicId)
    }
    
    func obtainImageUrl(comic: DetailComicModel) -> String{
        return comic.imageURL.path + "." +  comic.imageURL.thumbnailExtension
    }
    
    func obtainReleaseDate(comic: DetailComicModel) -> String {
        var releaseDate : String = ""
        comic.dates.forEach { comicDate in
            if comicDate.type == "onsaleDate" {
                releaseDate = comicDate.date
            }
        }
        
        if !releaseDate.isEmpty {
            let date = DateUtil.formatDate(date: releaseDate, formatInput: "yyyy-MM-dd'T'HH:mm:ssZ", formatOutput: "MMM d, yyyy")
            return date
        }
        
        return ""
    }
    
    func obtainPrice(comic: DetailComicModel) -> String {
        var price : Float = 0.0
        comic.prices.forEach { comicDate in
            if comicDate.type == "printPrice" {
                price = comicDate.price
            }
        }
        
        return price > 0.0 ? NumberUtil.formatToCurrency(numberToFormat: price, locale: "en_US") : ""
    }
    
    func obtainWriters(comic: DetailComicModel) -> String {
        var writers: [String] = []
        
        comic.comicCreators.creators.forEach { creator in
            if creator.role.contains("writer") {
                writers.append(creator.name)
            }
        }
        
        return writers.joined(separator: ", ")
    }
    
    func obtainArtists(comic: DetailComicModel) -> String {
        var artirsts: [String] = []
        
        comic.comicCreators.creators.forEach { creator in
            if creator.role.contains("penciller") || creator.role.contains("cover"){
                artirsts.append(creator.name)
            }
        }
        
        return artirsts.joined(separator: ", ")
    }
}
