//
//  MainViewModel.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 17/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class CategoryListViewModel: BaseViewModel {
    
    private let dataManager: JokesDataManager
    private let disposeBag = DisposeBag()
    
    private var categories: [Joke.Category] = []
    
    init(dataManager: JokesDataManager) {
        self.dataManager = dataManager
    }
    
    func getCategories() {
        postNewState(newState: .loading)
        dataManager.getCategories()
            .drive(onNext: { [weak self] result in
                if result.isSuccessFull {
                    guard let data =  result.content else { self?.postNewState(newState: .error); return }
                
                    self?.categories = data
                    self?.postNewState(newState: .success)
                }
                
            }).disposed(by: disposeBag)
    }

    // MARK: - Table View Data Source
    
    func numberOfRowsIn(section: Int) -> Int {
        return categories.count
    }
    
    func itemFor(indexPath: IndexPath) -> Joke.Category {
        return categories[indexPath.row]
    }
}
