//
//  Network.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 08/07/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation

protocol TargetType {
    var path: String { get }
    var method: HttpMethod { get }
    var baseURL: String { get }
    
    func getURL() -> URL
}

extension TargetType {
    func getURL() -> URL {
        let string = "\(baseURL)\(path)"
        return URL(string: string)!//Just dont
    }
}

public enum HttpMethod: String {
    case get = "GET"
}
