//
//  Joke.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 17/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import Mapper

struct Joke: Mappable {

    let id: String
    let value: String
    let icon: String?
    let category: Category?
    
    init(map: Mapper) throws {
        self.id = try map.from("id")
        self.value = try map.from("value")
        self.icon = map.optionalFrom("icon_url")
        self.category = map.optionalFrom("cateogry")
    }
    
    enum Category: String {
        case science
        case dev
        case explicit
        case movie
        case food
        case celebrity
        case sport
        case political
        case religion
        case animal
        case history
        case music
        case travel
        case career
        case money
        case fashion
        
        var giphy: String {
            get {
                var giphyUrl = ""
                switch self {
                case .animal: giphyUrl = "https://media.giphy.com/media/U8u2ftwuzNn9e/giphy.gif"
                case .explicit: giphyUrl = "https://media.giphy.com/media/26n6LAGRvrg9ZrREA/giphy.gif"
                case .dev: giphyUrl = "https://media.giphy.com/media/eQ3XbrudjQFuE/giphy.gif"
                case .movie: giphyUrl = "https://media.giphy.com/media/qanrUMM3x50mA/giphy.gif"
                case .money: giphyUrl = "https://media.giphy.com/media/3o7bu6od1b9J6grene/giphy.gif"
                case .food: giphyUrl = "https://media.giphy.com/media/l46Ce3W4xviv9dxKg/giphy.gif"
                case .fashion: giphyUrl = "https://media.giphy.com/media/7qZ3ZX1Gu3TZm/giphy.gif"
                case .celebrity: giphyUrl = "https://media.giphy.com/media/fR1SYquGo2NMJHdeQs/giphy.gif"
                case .science: giphyUrl = "https://media.giphy.com/media/SyzIHPW8oMdnW/giphy.gif"
                case .sport: giphyUrl = "https://media.giphy.com/media/l3q2NC9jSEX4yyKwU/giphy.gif"
                case .political: giphyUrl = "https://media.giphy.com/media/1125FQpCo6Ubhm/giphy.gif"
                case .religion: giphyUrl = "https://media.giphy.com/media/4M4LzMbq9sGBO/giphy.gif"
                case .history: giphyUrl = "https://media.giphy.com/media/V3pXX5Tzjrnmo/giphy.gif"
                case .music: giphyUrl = "https://media.giphy.com/media/XOQhsoJFZtKdq/giphy.gif"
                case .travel: giphyUrl = "https://media.giphy.com/media/K2ZWOSOLLYsAE/giphy.gif"
                case .career: giphyUrl = "https://media.giphy.com/media/WNuF3KK9NaQ8w/giphy.gif"
                }
                
                return giphyUrl
            }
        }
        
    }
}
