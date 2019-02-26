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
        let baseDriver: Driver<Result<[String]>> =  call(apiCall: .categories)
        return baseDriver.map { (result) in
            let stringCategoryArray = result.content
            var newResult = Result(content: Array<Joke.Category>())
            stringCategoryArray?.forEach { (category) in
                let enumCategory = Joke.Category(rawValue: category) ?? .dev
                newResult.content?.append(enumCategory)
            }
            return newResult
        }
    }
}
