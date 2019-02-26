//
//  BaseDataManager.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 17/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import Mapper
import Moya_ModelMapper

class BaseDataManager<API: TargetType> {

    private let provider: MoyaProvider<API>
    
    init(provider: MoyaProvider<API>) {
        self.provider = provider
    }
    
    func call<T: Mappable>(apiCall: API) -> Driver<Result<T>> {
        let newDriver = provider.rx.request(apiCall)
            .map { response -> Result<T> in
                let responseData = try response.map(to: T.self)
                let result = Result(content: responseData)
                return result
            }.asDriver(onErrorJustReturn: Result()).debug()

        return newDriver
    }
    
    func call<T: Mappable>(apiCall: API) -> Driver<Result<[T]>> {
        let newDriver = provider.rx.request(apiCall)
            .map { response -> Result<[T]> in
                let responseData = try response.map(to: [T].self)
                let result = Result(content: responseData)
                return result
            }.asDriver(onErrorJustReturn: Result()).debug()
        
        return newDriver
    }
    
    func call<T: Codable>(apiCall: API) -> Driver<Result<T>> {
        let newDriver = provider.rx.request(apiCall)
            .map { response -> Result<T> in
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(T.self, from: response.data)
                let result = Result(content: responseData)
                return result
            }.asDriver(onErrorJustReturn: Result()).debug()
        
        return newDriver
    }
}
