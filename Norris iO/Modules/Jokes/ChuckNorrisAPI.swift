//
//  ChuckNorrisAPI.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 14/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation

let baseUrl = "https://api.chucknorris.io/jokes/"

public enum ChuckNorrisAPI {
    case randomFrom(categoty: String)
    case search(query: String)
    case random
    case categories
}

extension ChuckNorrisAPI: TargetType {
    var baseURL: String {
        return baseUrl
    }
    
    public var method: HttpMethod {
        return .get
    }
    
    public var path: String {
        switch self {
        case .random,
             .randomFrom:
            return "random"
    
        case .categories:
            return "categories"
    
        case .search:
            return "search"
        }
    }
    
    public var parameters: [String: Any] {
        switch self {
        case .randomFrom(let category):
            return ["category": category]
            
        case .search(let query):
            return ["query": query]
            
        default:
            return [:]
        }
    }
}

