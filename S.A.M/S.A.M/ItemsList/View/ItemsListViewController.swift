//
//  ItemsListViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit
import RxSwift

class ItemsListViewController: UIViewController {
    
    @IBOutlet weak var tblItemsListTable: UITableView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    private var router = ItemsListRouter()
    private var viewModel : ItemsListViewModel?
    
    public var itemType: APIConstants.ItemsType?
    public var inputModel : Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        tblItemsListTable.register(UINib(nibName: "ItemCell", bundle: Bundle.main), forCellReuseIdentifier: "ItemCell")
        tblItemsListTable.rowHeight = UITableView.automaticDimension
        
        guard let itemType = self.itemType else { return }
        viewModel = ItemsListViewModel().specificViewModel(itemType: itemType)
        
        viewModel?.bind(view: self, router: router)
        
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func getData() {
        stopAndLoad(isLoaded: false)
        viewModel?.getData(with: inputModel) {
            self.reloadTableView()
        }
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
}

//MARK: -TableViewDelegate

extension ItemsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK: -TableViewDataSource
extension ItemsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCountItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        
        if let url = URL(string: viewModel?.getImageName(index: indexPath.row) ?? "") {
            cell.imgLeftImage.af.setImage(withURL:url)
            
        }
        
        cell.lblName.text = viewModel?.getItemName(index: indexPath.row)
        
        if let moreData = viewModel?.haveMoreData(index: indexPath.row) {
            if moreData {
                stopAndLoad(isLoaded: false)
                viewModel?.getMoreData {
                    self.reloadTableView()
                }
            }
        }
        
        return cell
    }
    
}
