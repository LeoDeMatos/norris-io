//
//  UITableView+Register.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 15/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib.init(nibName: identifier, bundle: nil)
    }
}
extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib.init(nibName: identifier, bundle: nil)
    }
}
