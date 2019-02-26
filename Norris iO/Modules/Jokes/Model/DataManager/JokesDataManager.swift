//
//  JokesDataManager.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 17/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

class JokesDataManager: BaseDataManager<ChuckNorrisAPI> {
    
    override init(provider: MoyaProvider<ChuckNorrisAPI>) {
        super.init(provider: provider)
    }
    
    func getJokes() -> Driver<Result<Joke>> {
        return call(apiCall: .random)
    }
    
    func randomJokeFor(category: String) -> Driver<Result<Joke>> {
        return call(apiCall: .randomFrom(categoty: category))
    }
    
    func getCategories() -> Driver<Result<[Joke.Category]>> {
        return call(apiCall: .categories)
    }
}
