//
//  MoviesCoordinator.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

final class MoviesCoordinator: Coordinator {
    private var navigationController = UINavigationController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let showMoviesViewController = MoviesViewController.instantiate()
        
        let moviesViewModel = MoviesViewModel()
        moviesViewModel.coordinator = self
        showMoviesViewController.viewModel = moviesViewModel
        
        navigationController.setViewControllers([showMoviesViewController], animated: true)
    }
    
    func showDitailMovie() {
        let aboutMovieCoordinator = AboutMovieCoordinator(navigationController: navigationController)
        aboutMovieCoordinator.start()
    }
}
