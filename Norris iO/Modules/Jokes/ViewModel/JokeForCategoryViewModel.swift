//
//  JokeForCategoryViewModel.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 19/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation

class JokeForCategoryViewModel: BaseViewModel {
    
    private let dataManager: JokesDataManager
    
    let category: String
    var joke: Joke?
    
    init(category: String, dataManager: JokesDataManager) {
        self.category = category
        self.dataManager = dataManager
    }
    
    func randomJokeForCategory(completion: @escaping (_ joke: Joke?) -> Void) {
        dataManager.randomJokeFor(category: category) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                completion(nil)
                
            case .success(let joke):
                self?.joke = joke
                completion(joke)
                
            }
        }
    }
}
