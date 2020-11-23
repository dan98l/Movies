//
//  MoviesCoordinator.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

final class MoviesCoordinator: Coordinator, MoviesViewModelDelegate {
    
    // MARK: - Properties
    private var navigationController = UINavigationController()
    var parentCoordinator: AppCoordinator?
    var dataMenager = DataManager()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let showMoviesViewController = MoviesViewController.instantiate()
        
        let moviesViewModel = MoviesViewModel(apiService: checkDataSourse())
        moviesViewModel.coordinator = self
        moviesViewModel.delegate = self
        showMoviesViewController.viewModel = moviesViewModel
        
        navigationController.setViewControllers([showMoviesViewController], animated: true)
    }
    
    func showDitailMovie() {
        let ditailMovieViewController = DitailMovieViewController.instantiate
               
        let ditailMovieViewModel = DitailMovieViewModel()
        ditailMovieViewModel.coordinator = self
        ditailMovieViewController().viewModel = ditailMovieViewModel

        navigationController.pushViewController(ditailMovieViewController(), animated: true)
        
        print("1 coordinator")
    }
    
    func showMenu() {
        parentCoordinator?.showMenu()
        print("2 coordinator")
    }
    
    func checkDataSourse() -> APIService {
        switch dataMenager.getDataSourse() {
        case "APIServiceTmbd":
            return APIServiceTmbd()
        case "APIServiceKinopoisk":
            return APIServiceKinopoisk()
        default:
           return APIServiceTmbd()
        }
    }
}
