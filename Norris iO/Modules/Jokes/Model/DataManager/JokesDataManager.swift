//
//  JokesDataManager.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 17/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation

class JokesDataManager: BaseDataManager<ChuckNorrisAPI> {
    
    override init(session: URLSession, decoder: JSONDecoder) {
        super.init(session: session, decoder: decoder)
    }
    
    func getJokes(completion: @escaping RequestCompletion<[Joke]>) {
        return call(apiCall: .random, completion: completion)
    }
    
    func randomJokeFor(category: String, completion: @escaping RequestCompletion<Joke>) {
        return call(apiCall: .randomFrom(categoty: category), completion: completion)
    }
    
    func getCategories(completion: @escaping RequestCompletion<[Joke.Category]>) {
        call(apiCall: .categories, completion: completion)
    }
}
