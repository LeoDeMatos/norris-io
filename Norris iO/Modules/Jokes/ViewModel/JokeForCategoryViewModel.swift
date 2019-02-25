//
//  JokeForCategoryViewModel.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 19/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import RxSwift

class JokeForCategoryViewModel: BaseViewModel {
    
    private let dataManager: JokesDataManager
    private let disposeBag = DisposeBag()
    
    let category: String
    var joke: Joke?
    
    init(category: String, dataManager: JokesDataManager) {
        self.category = category
        self.dataManager = dataManager
    }
    
    func randomJokeForCategory() {
        postNewState(newState: .loading)
        
        dataManager.randomJokeFor(category: category)
            .drive(onNext: { (result) in
                if result.isSuccessFull {
                    self.joke = result.content
                    self.postNewState(newState: .success)
                } else {
                    self.postNewState(newState: .error)
                }
            }).disposed(by: disposeBag)
    }
}
