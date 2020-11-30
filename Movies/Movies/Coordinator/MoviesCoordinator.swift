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
    var moviesViewModel: MoviesViewModel!
    var selectedDataSource: APIService!
    var showMoviesViewController: MoviesViewController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.selectedDataSource = self.checkDataSource()
    }
    
    func start() {
        showMoviesViewController = MoviesViewController.instantiate()
        moviesViewModel = MoviesViewModel(apiService: selectedDataSource)
        
        settingSearchBar()
        
        moviesViewModel.delegate = self
        showMoviesViewController.viewModel = moviesViewModel
        
        navigationController.setViewControllers([showMoviesViewController], animated: true)
    }
    
    func settingSearchBar() {
        switch selectedDataSource {
        case is APIServiceTmbd:
            showMoviesViewController.searchBar.isHidden = false
        case is APIServiceKinopoisk:
            showMoviesViewController.searchBar.isHidden = true
        default:
            break
        }
    }
    
    func showDetailMovie(index: Int) {
        let detailMovieViewController = DetailMovieViewController.instantiate()
        
        let movie = moviesViewModel.apiService.movies[index]
        
        let detailMovieViewModel = DetailMovieViewModel(movie: movie)
        detailMovieViewController.viewModel = detailMovieViewModel
        
//        moviesViewModel.getImageOfMovie(index: index, completion: { image in
//            detailMovieViewModel.imageMovie = image
//        })
        
        self.navigationController.pushViewController(detailMovieViewController, animated: true)
    }
    
    func updateMovieList() {
        selectedDataSource = self.checkDataSource()
        moviesViewModel.apiService = selectedDataSource
        settingSearchBar()
        showMoviesViewController.setupTableView()
        navigationController.setViewControllers([showMoviesViewController], animated: true)
    }
    
    func showMenu() {
        parentCoordinator?.showMenu()
    }
    
    func checkDataSource() -> APIService {
        switch dataMenager.getDataSource() {
        case "APIServiceTmbd":
            return APIServiceTmbd()
        case "APIServiceKinopoisk":
            return APIServiceKinopoisk()
        default:
           return APIServiceTmbd()
        }
    }
    
}
