//
//  MainViewModel.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 17/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation

class CategoryListViewModel: BaseViewModel {
    
    private let dataManager: JokesDataManager
    private var categories: [Joke.Category] = []
    
    init(dataManager: JokesDataManager) {
        self.dataManager = dataManager
    }
    
    func getCategories(completion: @escaping () -> Void) {
        dataManager.getCategories() { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
    
            case .success(let categories):
                self?.categories = categories
            }
            completion()
        }
    }

    // MARK: - Table View Data Source
    
    func numberOfRowsIn(section: Int) -> Int {
        return categories.count
    }
    
    func itemFor(indexPath: IndexPath) -> Joke.Category {
        return categories[indexPath.row]
    }
}
