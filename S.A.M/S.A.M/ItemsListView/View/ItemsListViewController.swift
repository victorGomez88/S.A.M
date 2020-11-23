//
//  ItemsListViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 19/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ItemsListViewController: UIViewController {

    @IBOutlet weak var tblItemsTableView: UITableView!
    
    @IBOutlet weak var lblAttributionText: UILabel!
    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!

    var viewModel: ItemsListViewModel?
    
    private var searchController: UISearchController?
    private var searchingResults: Bool = false
    
    var searchedText : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavBarSettings
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.isTranslucent = false
        self.title = viewModel?.obtainTitle()
        
        self.customBackButton(title: "Dashboard")
        
        tblItemsTableView.register(UINib(nibName: viewModel?.obtainCellName() ?? "", bundle: Bundle.main), forCellReuseIdentifier: viewModel?.obtainCellName() ?? "")
        tblItemsTableView.rowHeight = UITableView.automaticDimension
        tblItemsTableView.separatorStyle = .none
    
        viewModel?.bind(view: self)
        
        getData()
        
        if !(viewModel is StoriesListViewModel) {
            searchBarManager()
        }
        
    }
    
    override func backButtonAction(sender: UIBarButtonItem?) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController?.isActive = false
    }
    
    func obtainViewModel() -> ItemsListViewModel {
        return ItemsListViewModel()
    }

    func getData(searchText: String? = "", offset: Int? = 0, fromSearch: Bool? = false) {
        stopAndLoad(isLoaded: false)
        
        viewModel?.getData(searchedText: searchText ?? "", offset: offset ?? 0, fromSearch: fromSearch ?? false, onNext: {
            self.reloadTableView()
            
            self.showEmptyTableView(show: self.viewModel?.showEmptyBackground() ?? false)
            self.tblItemsTableView.isScrollEnabled = !(self.viewModel?.showEmptyBackground() ?? false)
            
            self.lblAttributionText.text = self.viewModel?.obtainAttributionText()
            
        })
        
    }

    func reloadTableView() {
        DispatchQueue.main.async {
            self.stopAndLoad(isLoaded: true)
            self.tblItemsTableView.reloadData()
        }
    }
    
    private func stopAndLoad(isLoaded: Bool) {
        if isLoaded {
            activityLoader.stopAnimating()
            tblItemsTableView.setContentOffset(tblItemsTableView.contentOffset, animated:false)
            tblItemsTableView.isUserInteractionEnabled = isLoaded
        } else {
            activityLoader.startAnimating()
            tblItemsTableView.isUserInteractionEnabled = isLoaded
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
        searchController?.searchBar.placeholder = viewModel?.obtainSearchPlaceholder()
        
        let searchBar = searchController?.searchBar
        searchBar?.delegate = self
        tblItemsTableView.tableHeaderView = searchBar
    }
    
    
    func showEmptyTableView(show: Bool) {
        let emptyView = TableEmptyView(frame: tblItemsTableView.backgroundView?.frame ?? CGRect())
        emptyView.setEmptyMessage(message: viewModel?.obtainEmptyMsg() ?? "")
        tblItemsTableView.backgroundView = show ? emptyView : nil
    }
}

//MARK: -TableViewDelegate

extension ItemsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.obtainCellHeight() ?? 0.0
    }
}

//MARK: -TableViewDataSource
extension ItemsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.obtainCellCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = viewModel?.obtainCell(with: tableView, index: indexPath.row, searchedText: searchedText), let viewModel = viewModel else { return UITableViewCell()}
        
        if viewModel.hasMoreData(index: indexPath.row) {
            if let text = searchedText {
                self.getData(searchText: text, offset: ((viewModel.offset ?? 0) + 20))
            } else {
                self.getData(offset: ((viewModel.offset ?? 0 ) + 20))
            }
        
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.navigateToDetail(with: indexPath.row)
    }
    
}

//MARK: - SearchController settings
extension ItemsListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        stopAndLoad(isLoaded: false)
        searchedText = searchBar.text
        
        self.getData(searchText: searchedText, fromSearch: true)
        searchController?.isActive = false
        searchController?.searchBar.text = searchedText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        stopAndLoad(isLoaded: false)
        
        self.getData(fromSearch: true)
    }
}

    

