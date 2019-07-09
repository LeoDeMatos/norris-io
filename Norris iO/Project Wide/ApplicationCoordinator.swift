//
//  ApplicationCoordinator.swift
//  Norris iO
//
//  Created by Leonardo de Matos on 14/02/19.
//  Copyright © 2019 Leonardo de Matos. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    var children: [Coordinator] = []
    
    let rootViewController: UINavigationController
    let session: URLSession
    let dataManager: JokesDataManager
    let jsonDecoder: JSONDecoder
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.barTintColor = .chuckOrange
        self.rootViewController.navigationBar.tintColor = .chuckBlue
        self.rootViewController.navigationBar.isTranslucent = false
        
        let textAttr = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.rootViewController.navigationBar.titleTextAttributes = textAttr
        
        if #available(iOS 11.0, *) {
            self.rootViewController.navigationBar.largeTitleTextAttributes = textAttr
        }
        
        self.window.rootViewController = rootViewController
        
        self.session = URLSession.shared
        self.jsonDecoder = JSONDecoder()
        dataManager = JokesDataManager(session: session, decoder: jsonDecoder)
        
        if #available(iOS 11.0, *) {
            self.rootViewController.navigationBar.prefersLargeTitles = true
        }
    }
    
    func start() {
        let viewModel = CategoryListViewModel(dataManager: dataManager)
        let viewController = CategoryListViewController()
        viewController.viewModel = viewModel
        viewController.delegate = self
        
        self.rootViewController.pushViewController(viewController, animated: false)
    }
    
    func showJokesFor(category: String) {
        let viewModel = JokeForCategoryViewModel(
            category: category, dataManager: dataManager)
        
        let viewController = JokeForCategoryViewController()
        viewController.viewModel = viewModel
        self.rootViewController.pushViewController(viewController, animated: true)
    }
    
    func addChild(coordinator: Coordinator) {
        children.append(coordinator)
    }
}

// MARK: - CategoryListViewController Delegate

extension ApplicationCoordinator: CategoryListViewControllerDelegate {
    func didSelectedCategory(category: String) {
        showJokesFor(category: category)
    }
}
