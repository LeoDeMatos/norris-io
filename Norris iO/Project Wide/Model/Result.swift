//
//  Result.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 17/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import Mapper

struct Result<Content> {
    
    init(content: Content) {
        self.content = content
    }
    
    init() {}
    
    var error: String? = nil
    var content: Content? = nil
    var isSuccessFull: Bool {
        return content != nil
    }
}
