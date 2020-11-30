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
    var moviesViewController: MoviesViewController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.selectedDataSource = self.checkDataSource()
    }
    
    func start() {
        moviesViewController = MoviesViewController.instantiate()
        moviesViewModel = MoviesViewModel(apiService: selectedDataSource)
        
        settingSearchBar()
        
        moviesViewModel.delegate = self
        moviesViewController.viewModel = moviesViewModel
        
        navigationController.setViewControllers([moviesViewController], animated: true)
    }
    
    func settingSearchBar() {
        switch selectedDataSource {
        case is APIServiceTmbd:
            moviesViewController.searchBar.isHidden = false
        case is APIServiceKinopoisk:
            moviesViewController.searchBar.isHidden = true
        default:
            break
        }
    }
    
    func showDetailMovie(index: Int) {
        let detailMovieViewController = DetailMovieViewController.instantiate()
        let detailMovieViewModel = DetailMovieViewModel(movie: selectedDataSource.movies[index], apiService: selectedDataSource)
        
        detailMovieViewController.viewModel = detailMovieViewModel
        
        self.navigationController.pushViewController(detailMovieViewController, animated: true)
    }
    
    func updateMovieList() {
        selectedDataSource = self.checkDataSource()
        moviesViewModel.apiService = selectedDataSource
        moviesViewModel.statusOfLoadMovie.page = 1
        settingSearchBar()
        moviesViewController.setupTableView()
        navigationController.setViewControllers([moviesViewController], animated: true)
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
