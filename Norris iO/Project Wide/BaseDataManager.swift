//
//  BaseDataManager.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 17/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import Combine

protocol DataManagerProtocol: AnyObject {
    associatedtype API: TargetType
    func call<T: Codable>(apiCall: API, completion: @escaping (_ result: Result<T, Error>) -> Void)
    func call(apiCall: API,completion: @escaping (_ result: Result<String, Error>) -> Void)
}

typealias RequestCompletion<T> = (_ result: Result<T, Error>) -> Void

class BaseDataManager<API: TargetType>: DataManagerProtocol {

    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    func call<T: Codable>(apiCall: API, completion: @escaping RequestCompletion<T>) {
    
        if #available(iOS 13, *) {
            callWithCombine(apiCall: apiCall, completion: completion)
        } else {
            callWithRegular(apiCall: apiCall, completion: completion)
        }
    }
    
    @available(iOS 13, *)
    private func callWithCombine<T: Codable>(apiCall: API, completion: @escaping RequestCompletion<T>) {
        let url = apiCall.getURL()
        var request = URLRequest(url: url)
        request.httpMethod = apiCall.method.rawValue
        let publisher = session.dataTaskPublisher(for: request)
        
        _ = publisher
            .tryMap { data, _ in return data }
            .decode(type: T.self, decoder: decoder)
            .mapError({ error -> Error in
                print(error.localizedDescription)
                return error
            })
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (data) in
                completion(.success(data))
            })
    }
    
    private func callWithRegular<T: Codable>(apiCall: API, completion: @escaping RequestCompletion<T>) {
        let url = apiCall.getURL()
        var request = URLRequest(url: url)
        request.httpMethod = apiCall.method.rawValue
        
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            guard error == nil, let data = data else { completion(.failure(error!)); return }
            
            if let decodedData = try? self?.decoder.decode(T.self, from: data) {
                completion(.success(decodedData!))
            }
        }
        
        task.resume()
    }
}
