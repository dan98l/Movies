//
//  MenuCoordinator.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

final class MenuCoordinator: Coordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let menuViewController = AboutMovieViewController.instantiate
        
        let menuViewModel = AboutMovieViewModel()
        menuViewModel.coordinator = self
        menuViewController().viewModel = menuViewModel
        
        navigationController.pushViewController(menuViewController(), animated: true)
    }
}
 
