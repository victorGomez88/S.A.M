//
//  CharactersListViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import RxSwift

class CharactersListViewModel: ItemsListViewModel {
    
    private var charactersModel : CharactersModel?
    private var charactersList = [CharacterModel]()
    
    public func getCharactersListData(_ inputModel: CharactersInputModel?) -> Observable<CharactersModel> {
        return CharacterService().getCharactersList(inputModel: inputModel)
    }
    
    override func obtainDetailVC(with index: Int) -> UIViewController{
        let storyboard = UIStoryboard(name: "CharacterDetail", bundle: nil)
        let vc : CharacterDetailViewController = storyboard.instantiateViewController(withIdentifier: "CharacterDetailViewControllerId") as! CharacterDetailViewController
        vc.characterId = charactersList[index].id
        return vc
    }
    
    //MARK: - GET DATA FROM SERVICE
    override func getData(searchedText: String? = "", offset: Int? = 0, fromSearch: Bool? = false, onNext: (@escaping() -> Void)) {
        let inputModel = CharactersInputModel.init(nameStartsWith: searchedText, offset: offset)
        
        return getCharactersListData(inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                
                self.charactersModel = modelData
                self.offset = self.charactersModel?.data.offset
                
                if fromSearch ?? false {
                    self.charactersList = modelData.data.charactersList
                } else {
                    self.charactersList.append(contentsOf: modelData.data.charactersList)
                }
                
                onNext()

            }, onError: { error in
                let alert = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    self.view?.backButtonAction(sender: nil)
                }))
                
                self.view?.present(alert, animated: true)
            }).disposed(by: disposeBag)
    
    }
    
    //MARK: - TITLE VIEWCONTROLLER
    override func obtainTitle() -> String {
        return NSLocalizedString("Characters", comment: "Characters")
    }

    //MARK: - CELL CONFIGURATION
    override func obtainCellName() -> String {
        return "CharacterCell"
    }
    
    override func obtainCellHeight() -> CGFloat {
        return 100
    }
    
    override func obtainCellCount() -> Int {
        return self.charactersList.count
    }
    
    override func obtainCell(with tableView: UITableView, index: Int, searchedText: String?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: obtainCellName()) as! CharacterCell
        
        cell.selectionStyle = .none
        if let url = URL(string: charactersList[index].imageURL.path + "." +  charactersList[index].imageURL.thumbnailExtension) {
            cell.imgLeftImage.af.setImage(withURL:url, placeholderImage: UIImage(named:"placeholder"))
        }

        cell.lblName.text = charactersList[index].name
        
        return cell
    }
    
    override func hasMoreData(index: Int)  -> Bool {
    
        if let charactersModel = self.charactersModel {
            return index == (charactersList.count - 1) && index < (charactersModel.data.total - 1)
        }
        
        return false
    }
    
    //MARK: -EMPTY STATE
    override func showEmptyBackground() -> Bool {
        return charactersList.count == 0
    }
    
    override func obtainEmptyMsg() -> String {
        return NSLocalizedString("CharactersEmptyTableMessage", comment: "CharactersEmptyTableMessage")
    }
    
    
    //MARK: - SEARCH PLACEHOLDER
    override func obtainSearchPlaceholder() -> String {
        return NSLocalizedString("CharactersSearchPlaceholder", comment: "CharactersSearchPlaceholder")
    }
    
    
    //MARK: - ATTRIBUTION TEXT 
    override func obtainAttributionText() -> String {
        return charactersModel?.attributionText ?? ""
    }
    
}
