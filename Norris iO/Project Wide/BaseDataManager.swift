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

class BaseDataManager<P: TargetType> {

    private let provider: MoyaProvider<P>
    
    init(provider: MoyaProvider<P>) {
        self.provider = provider
    }
    
    func call<T: Mappable>(apiCall: P) -> Driver<Result<T>> {
        let newDriver = provider.rx.request(apiCall)
            .map { response -> Result<T> in
                let responseData = try response.map(to: T.self)
                let result = Result(content: responseData)
                return result
            }.asDriver(onErrorJustReturn: Result()).debug()

        return newDriver
    }
    
    func call<T: Mappable>(apiCall: P) -> Driver<Result<[T]>> {
        let newDriver = provider.rx.request(apiCall)
            .map { response -> Result<[T]> in
                let responseData = try response.map(to: [T].self)
                let result = Result(content: responseData)
                return result
            }.asDriver(onErrorJustReturn: Result()).debug()
        
        return newDriver
    }
    
    func call(apiCall: P) -> Driver<Result<[String]>> {
        let newDriver = provider.rx.request(apiCall)
            .map { response -> Result<[String]> in
                let decoder = JSONDecoder()
                let responseData = try decoder.decode([String].self, from: response.data)
                let result = Result(content: responseData)
                return result
            }.asDriver(onErrorJustReturn: Result()).debug()
        
        return newDriver
    }
}
