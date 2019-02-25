//
//  UIImageView+NetworkLoading.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 19/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func load(url: String){
        if let resource = URL(string: url) {
            self.kf.setImage(with: resource, options: [.transition(ImageTransition.fade(1))])
        }
    }
}
