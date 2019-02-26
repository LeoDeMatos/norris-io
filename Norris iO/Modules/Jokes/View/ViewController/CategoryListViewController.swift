//
//  ViewController.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 14/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import UIKit
import Cartography

protocol CategoryListViewControllerDelegate: class {
    func didSelectedCategory(category: String)
}

class CategoryListViewController: UIViewController {

    // MARK: - Views
    
    private lazy var tableView: UITableView = {
       let table = UITableView()
        return table
    }()

    var delegate: CategoryListViewControllerDelegate?
    var viewModel: CategoryListViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
    }
    
    // MARK: - View Configuration
    private func configureView() {
        self.navigationItem.title = "El Chucky Norris"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    
        self.view.addSubview(tableView)
        constrain(self.view, tableView) { (v, table) in
            table.edges == v.edges
        }
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(CategoryTableViewCell.nib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
    
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .automatic
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configureViewModel() {
        viewModel.register { (newState) in
            switch newState {
                case .loading,
                     .start:
                    print("viewModel start")

                case .success,
                     .done,
                     .error:
                    self.tableView.reloadSections([0], with: .left)
            }
        }
        viewModel.getCategories()
    }
    
    // MARK: - Refresh Control Target
    
}

// MARK: - Table View Delegate

extension CategoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = viewModel.itemFor(indexPath: indexPath)
        delegate?.didSelectedCategory(category: item.rawValue)
    }
}

// MARK: - Table View Data Source

extension CategoryListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as! CategoryTableViewCell
        var category = viewModel.itemFor(indexPath: indexPath)
        cell.bind(category: category.rawValue, giphyUrl: category.giphy)
        return cell
    }
}
