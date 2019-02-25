//
//  JokeForCategoryViewController.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 17/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import UIKit
import Cartography

class JokeForCategoryViewController: UIViewController {

    // MARK: - Views
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var jokeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = -1
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var newJokeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .chuckOrange
        button.setTitle("New Joke", for: .normal)
        button.setTitle("Getting New Joke...", for: .disabled)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(newJokeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var viewModel: JokeForCategoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
    }
    
    private func configureView() {
        navigationItem.title = viewModel.category.capitalized
        navigationItem.backBarButtonItem = UIBarButtonItem()
        view.backgroundColor = .black
    
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(imageView)
        constrain(view, imageView) { (v, img) in
            img.top == v.top + 50
            img.height == 50
            img.centerX == v.centerX
            img.width == 50
        }
        
        view.addSubview(jokeLabel)
        constrain(imageView, view, jokeLabel) { (img, v, label) in
            label.top == img.bottom + 20
            label.left == v.left + 20
            label.right == v.right - 20
        }
        
        view.addSubview(newJokeButton)
        constrain(newJokeButton, view) { (button, v) in
            button.height == 40
            button.width == 300
            button.centerX == v.centerX
            button.bottom == v.bottom - 20
        }
    }
    
    @objc func newJokeButtonTapped(sender: UIButton) {
        viewModel.randomJokeForCategory()
    }
    
    // MARK: - ViewModel Configuration
    
    private func configureViewModel() {
        viewModel.register { [weak self] (newState) in
            switch newState {
            case .start,
                 .loading:
                self?.newJokeButton.isEnabled = false
            case .success:
                self?.newJokeButton.isEnabled = true
                self?.jokeLabel.text = self?.viewModel.joke?.value
                let icon = self?.viewModel.joke?.icon ?? ""
                self?.imageView.load(url: icon)
                
            default:
                print(newState)
                
            }
        }
        viewModel.randomJokeForCategory()
    }
}
