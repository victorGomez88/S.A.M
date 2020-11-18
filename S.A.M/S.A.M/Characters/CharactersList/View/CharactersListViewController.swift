//
//  CharacterListViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CharactersListViewController: UIViewController {
    
    @IBOutlet weak var tblItemsListTable: UITableView!
    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var lblDataProviding: UILabel!
    
    private var router = CharactersListRouter()
    private var viewModel = CharactersListViewModel()
    private var searchController: UISearchController?
    private var searchingResults: Bool = false
    private var searchedText : String?
    
    public var disposeBag = DisposeBag()
    private var charactersModel : CharactersModel?
    private var charactersList = [CharacterModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavBarSettings
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        self.title = NSLocalizedString("Characters", comment: "Characters")
        
        tblItemsListTable.register(UINib(nibName: "CharacterCell", bundle: Bundle.main), forCellReuseIdentifier: "CharacterCell")
        tblItemsListTable.rowHeight = UITableView.automaticDimension
        tblItemsListTable.separatorStyle = .none
    
        viewModel.bind(view: self, router: router)
        
        getData(inputModel: nil)
        
        searchBarManager()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func getData(inputModel: CharactersInputModel?, fromSearch: Bool? = false) {
        stopAndLoad(isLoaded: false)
        
        return viewModel.getCharactersListData(inputModel)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (modelData) in
                self.charactersModel = modelData
                
                if fromSearch ?? false {
                    self.charactersList = modelData.data.charactersList
                } else {
                    self.charactersList.append(contentsOf: modelData.data.charactersList)
                }
                self.reloadTableView()
                
                self.showEmptyTableView(show: self.charactersList.isEmpty)
                self.tblItemsListTable.isScrollEnabled = !self.charactersList.isEmpty
                
                self.lblDataProviding.text = self.charactersModel?.attributionText
                
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
        
    }

    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.stopAndLoad(isLoaded: true)
            self.tblItemsListTable.reloadData()
        }
    }
    
    private func stopAndLoad(isLoaded: Bool) {
        if isLoaded {
            self.activityLoader.stopAnimating()
            tblItemsListTable.setContentOffset(tblItemsListTable.contentOffset, animated:false)
            self.tblItemsListTable.isUserInteractionEnabled = isLoaded
        } else {
            self.activityLoader.startAnimating()
            self.tblItemsListTable.isUserInteractionEnabled = isLoaded
        }
    }
    
    
    //MARK: - SearchController

    private func searchBarManager() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.obscuresBackgroundDuringPresentation = self.traitCollection.userInterfaceStyle == .dark
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.searchBar.barStyle = self.traitCollection.userInterfaceStyle == .dark ? .black : .default
        searchController?.searchBar.backgroundColor = .clear
        searchController?.searchBar.placeholder = NSLocalizedString("CharactersSearchPlaceholder", comment: "CharactersSearchPlaceholder")
        
        let searchBar = searchController?.searchBar
        searchBar?.delegate = self
        tblItemsListTable.tableHeaderView = searchBar
    }
    
    
    private func showEmptyTableView(show: Bool) {
        if show {
            let emptyView = TableEmptyView(frame: tblItemsListTable.backgroundView?.frame ?? CGRect())
            emptyView.setEmptyMessage(message: NSLocalizedString("CharactersEmptyTableMessage", comment: "CharactersEmptyTableMessage"))
            tblItemsListTable.backgroundView = emptyView
        } else {
            tblItemsListTable.backgroundView = nil
        }
    }
}

//MARK: -TableViewDelegate

extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK: -TableViewDataSource
extension CharactersListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as! CharacterCell
        
        if let url = URL(string: charactersList[indexPath.row].imageURL.path + "." +  charactersList[indexPath.row].imageURL.thumbnailExtension) {
            cell.imgLeftImage.af.setImage(withURL:url)
        }
        
        cell.lblName.text = charactersList[indexPath.row].name
        
        if let charactersModel = charactersModel, indexPath.row == charactersModel.data.offset + (charactersModel.data.count - 1) && indexPath.row < charactersModel.data.total{
            
            if let text = searchedText {
                self.getData(inputModel: CharactersInputModel.init(nameStartsWith: text, offset: (charactersModel.data.offset ) + 20))
            } else {
                self.getData(inputModel: CharactersInputModel.init(offset: (charactersModel.data.offset ) + 20))
            }
        }
        
        return cell
    }
    
}

//MARK: - SearchController settings
extension CharactersListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        stopAndLoad(isLoaded: false)
        searchedText = searchBar.text
        
        self.getData(inputModel: CharactersInputModel.init(nameStartsWith: searchedText), fromSearch: true)
        searchController?.isActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        stopAndLoad(isLoaded: false)
        
        self.getData(inputModel: nil, fromSearch: true)
    }
}
