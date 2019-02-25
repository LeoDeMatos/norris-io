//
//  ChuckNorrisAPI.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 14/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import Moya
import Alamofire

let baseUrl = "https://api.chucknorris.io/jokes/"

public enum ChuckNorrisAPI {
    case randomFrom(categoty: String)
    case search(query: String)
    case random
    case categories
}

extension ChuckNorrisAPI: TargetType {
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "no sample data".data(using: String.Encoding.utf8)!
    }

    public var headers: [String : String]? {
        return nil
    }
    
    public var baseURL: URL {
        return  URL(string: baseUrl)!
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
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
        
    public var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
}

