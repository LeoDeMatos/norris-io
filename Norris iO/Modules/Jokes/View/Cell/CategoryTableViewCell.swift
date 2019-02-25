//
//  CategoryTableViewCell.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 15/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.contentMode = .scaleToFill
        mainImageView.clipsToBounds = true
        
        let layer = CAGradientLayer()
        layer.frame = mainImageView.bounds
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        mainImageView.layer.insertSublayer(layer, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Cell Binding
    
    func bind(category: String, giphyUrl: String) {
        categoryTitleLabel.text = category.capitalized
        mainImageView.load(url: giphyUrl)
    }
}
