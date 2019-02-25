//
//  BaseViewModel.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 17/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ViewModelState {
    case start
    case loading
    case error
    case done
    case success
}

class BaseViewModel {
    private let state = BehaviorRelay<ViewModelState>(value: .start)
    
    func postNewState(newState: ViewModelState) {
        state.accept(newState)
    }
    
    func register(observer: @escaping (_ newState: ViewModelState) -> Void) {
        state.asDriver().drive(onNext: observer)
    }
}
