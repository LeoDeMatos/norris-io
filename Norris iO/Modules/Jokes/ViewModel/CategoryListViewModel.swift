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

typealias JokeCategory = String
typealias GiphyUrl = String
typealias CategoryBundle = [JokeCategory: GiphyUrl]

class CategoryListViewModel: BaseViewModel {
    
    private let dataManager: JokesDataManager
    private let disposeBag = DisposeBag()
    
    private var categories: [CategoryBundle] = []
    
    init(dataManager: JokesDataManager) {
        self.dataManager = dataManager
    }
    
    func getCategories() {
        postNewState(newState: .loading)
        dataManager.getCategories()
            .drive(onNext: { [weak self] result in
                if result.isSuccessFull {
                    guard let data =  result.content else { self?.postNewState(newState: .error); return }
                
                    self?.buildCategories(categories: data)
                    self?.postNewState(newState: .success)
                }
                
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Category List Build
    
    private func buildCategories(categories: [String]) {
        for category in categories {
            var giphyUrl = ""
            switch category {
            case Joke.Category.animal.rawValue:
                giphyUrl = "https://media.giphy.com/media/U8u2ftwuzNn9e/giphy.gif"
            case Joke.Category.explicit.rawValue:
                giphyUrl = "https://media.giphy.com/media/26n6LAGRvrg9ZrREA/giphy.gif"
            case Joke.Category.dev.rawValue:
                giphyUrl = "https://media.giphy.com/media/eQ3XbrudjQFuE/giphy.gif"
            case Joke.Category.movie.rawValue:
                giphyUrl = "https://media.giphy.com/media/qanrUMM3x50mA/giphy.gif"
            case Joke.Category.money.rawValue:
                giphyUrl = "https://media.giphy.com/media/3o7bu6od1b9J6grene/giphy.gif"
            case Joke.Category.food.rawValue:
                giphyUrl = "https://media.giphy.com/media/l46Ce3W4xviv9dxKg/giphy.gif"
            case Joke.Category.fashion.rawValue:
                giphyUrl = "https://media.giphy.com/media/7qZ3ZX1Gu3TZm/giphy.gif"
            case Joke.Category.celebrity.rawValue:
                giphyUrl = "https://media.giphy.com/media/fR1SYquGo2NMJHdeQs/giphy.gif"
            case Joke.Category.science.rawValue:
                giphyUrl = "https://media.giphy.com/media/SyzIHPW8oMdnW/giphy.gif"
            case Joke.Category.sport.rawValue:
                giphyUrl = "https://media.giphy.com/media/l3q2NC9jSEX4yyKwU/giphy.gif"
            case Joke.Category.political.rawValue:
                giphyUrl = "https://media.giphy.com/media/1125FQpCo6Ubhm/giphy.gif"
            case Joke.Category.religion.rawValue:
                giphyUrl = "https://media.giphy.com/media/4M4LzMbq9sGBO/giphy.gif"
            case Joke.Category.history.rawValue:
                giphyUrl = "https://media.giphy.com/media/V3pXX5Tzjrnmo/giphy.gif"
            case Joke.Category.music.rawValue:
                giphyUrl = "https://media.giphy.com/media/XOQhsoJFZtKdq/giphy.gif"
            case Joke.Category.travel.rawValue:
                giphyUrl = "https://media.giphy.com/media/K2ZWOSOLLYsAE/giphy.gif"
            case Joke.Category.career.rawValue:
                giphyUrl = "https://media.giphy.com/media/WNuF3KK9NaQ8w/giphy.gif"
    
            default:
                giphyUrl = ""
            }
            
            let bundle: CategoryBundle =  [category: giphyUrl]
            self.categories.append(bundle)
        }
    }
    
    // MARK: - Table View Data Source
    
    func numberOfRowsIn(section: Int) -> Int {
        return categories.count
    }
    
    func itemFor(indexPath: IndexPath) -> CategoryBundle{
        return categories[indexPath.row]
    }
}
