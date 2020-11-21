//
//  CharacterDetailViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 18/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    //NAME
    @IBOutlet weak var nameViewContainer: UIView!
    @IBOutlet weak var lblNameValue: UILabel!
    
    //DESCRIPTION
    @IBOutlet weak var descriptionViewContainer: UIView!
    @IBOutlet weak var lblDescriptionValue: UILabel!
    
    //External Links
    @IBOutlet weak var externalLinksView: ExternalLinksView!
    
    //Attributtion
    @IBOutlet weak var lblAttributionValue: UILabel!
    
    private var viewModel = CharacterDetailViewModel()
    var disposeBag = DisposeBag()
    
    public var characterId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Details", comment: "Details")
        
        viewModel.bind(view: self)
        getCharacterData()
    }
    
    private func getCharacterData() {
        return viewModel.getCharacterData(characterId ?? 0)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe { (characterData) in
                self.updateView(characterData: characterData)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func updateView(characterData: CharacterDetailModel) {
        
        guard let character = characterData.data.characterDetail.first else { return }
        
        //Image
        if let url = URL(string: character.imageURL.path + "." +  character.imageURL.thumbnailExtension) {
            characterImageView.af.setImage(withURL:url)
        }
        
        //Name
        nameViewContainer.isHidden = character.name.isEmpty
        lblNameValue.text = character.name
        
        //Description
        descriptionViewContainer.isHidden = character.characterDescription.isEmpty
        lblDescriptionValue.text = character.characterDescription
        
        //ExternalLinks
        character.urls.forEach { url in
            if url.type == "detail" && !url.url.isEmpty {
                externalLinksView.setLeftLink(with: NSLocalizedString("DetailsLink", comment: "DetailsLink"), urlPath: url.url)
            }
            
            //If url contains the path /comics/ show the link to the web
            if url.type == "comiclink" && !url.url.isEmpty && url.url.contains("/comics/") {
                externalLinksView.setRightLink(with: String(format:NSLocalizedString("ComicsLink", comment: "ComicsLink"),character.name), urlPath: url.url)
            }
        }
        
        externalLinksView.isHidden = externalLinksView.isComponenteHidden()
        
        //Attributtion
        lblAttributionValue.text = characterData.attributionText
    }
}
