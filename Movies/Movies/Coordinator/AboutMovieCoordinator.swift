//
//  AboutMovieCoordinator.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

final class AboutMovieCoordinator: Coordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let aboutMovieViewController = DitailMovieViewController.instantiate
        
        let aboutMovieViewModel = AboutMovieViewModel()
        aboutMovieViewModel.coordinator = self
        aboutMovieViewController().viewModel = aboutMovieViewModel
        
        navigationController.pushViewController(aboutMovieViewController(), animated: true)
    }
}
 
