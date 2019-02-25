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
    }
    
    let id: String
    let value: String
    let icon: String?
    let category: String?
    
    init(map: Mapper) throws {
        self.id = try map.from("id")
        self.value = try map.from("value")
        self.icon = map.optionalFrom("icon_url")
        self.category = map.optionalFrom("cateogry")
    }
}
