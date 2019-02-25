//
//  Coordinator.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 14/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation

protocol Coordinator {
    func start()
    func addChild(coordinator: Coordinator)
}
// PROTOCOL EXTENSION addChild
