//
//  MoviesCoordinator.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

final class MoviesCoordinator: Coordinator, MoviesViewModelDelegate, DitailMovieViewModelDelegate {
    
    // MARK: - Properties
    private var navigationController = UINavigationController()
    var parentCoordinator: AppCoordinator?
    var dataMenager = DataManager()
    var moviesViewModel: MoviesViewModel!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let showMoviesViewController = MoviesViewController.instantiate()
        self.moviesViewModel = MoviesViewModel(apiService: checkDataSourse())
        moviesViewModel.coordinator = self
        moviesViewModel.delegate = self
        showMoviesViewController.viewModel = moviesViewModel
        
        switch checkDataSourse() {
        case is APIServiceTmbd:
            showMoviesViewController.searchBar.isHidden = false
        case is APIServiceKinopoisk:
            showMoviesViewController.searchBar.isHidden = true
        default:
            break
        }
        
        navigationController.setViewControllers([showMoviesViewController], animated: true)
    }
    
    func showDitailMovie(index: Int) {
        let ditailMovieViewController = DitailMovieViewController.instantiate()
        
        let movie = moviesViewModel.apiService.popularMovies[index]
        
        let ditailMovieViewModel = DitailMovieViewModel(movie: movie)
        
        ditailMovieViewModel.delegate = self
        ditailMovieViewController.viewModel = ditailMovieViewModel
        
        guard let posterPath = movie.posterPath else { return }
        
        checkDataSourse().getImageMovie(posterPath: posterPath) { data in
            ditailMovieViewModel.dataImage = data
            self.navigationController.pushViewController(ditailMovieViewController, animated: true)
        }
    }
    
    func showMenu() {
        parentCoordinator?.showMenu()
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
