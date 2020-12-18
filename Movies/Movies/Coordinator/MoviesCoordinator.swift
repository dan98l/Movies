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
    var moviesViewModel: MoviesViewModel?
    var selectedDataSource: APIService?
    var moviesViewController: MoviesViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.selectedDataSource = self.checkDataSource()
    }
    
    func start() {
        moviesViewController = MoviesViewController.instantiate()
        if let selectedDataSource = selectedDataSource, let beams = dataMenager.beamsStars() {
            moviesViewModel = MoviesViewModel(apiService: selectedDataSource, beamsStars: beams)
        }
        
        settingSearchBar()
        
        if let moviesViewModel = moviesViewModel {
            moviesViewModel.delegate = self
        }
        
        if let moviesViewController = moviesViewController {
            moviesViewController.viewModel = moviesViewModel
            navigationController.setViewControllers([moviesViewController], animated: true)
        }
    }
    
    func settingSearchBar() {
        switch selectedDataSource {
        case is APIServiceTmbd:
            if let moviesViewController = moviesViewController {
                moviesViewController.searchBar.isHidden = false
            }
        case is APIServiceKinopoisk:
            if let moviesViewController = moviesViewController {
                moviesViewController.searchBar.isHidden = true
            }
        default:
            break
        }
    }
    
    func showDetailMovie(index: Int) {
        let detailMovieViewController = DetailMovieViewController.instantiate()
        if let selectedDataSource = selectedDataSource {
            let detailMovieViewModel = DetailMovieViewModel(movie: selectedDataSource.movies[index], apiService: selectedDataSource)
            detailMovieViewController.viewModel = detailMovieViewModel
            self.navigationController.pushViewController(detailMovieViewController, animated: true)
        }
    }
    
    func updateMovieList() {
        selectedDataSource = self.checkDataSource()
        if let moviesViewModel = moviesViewModel {
            moviesViewModel.apiService = selectedDataSource
            moviesViewModel.movieLoadStatus.page = 1
            moviesViewModel.beamsStars = dataMenager.beamsStars()
        }
        settingSearchBar()
        if let moviesViewController = moviesViewController {
            moviesViewController.setupTableView()
            navigationController.setViewControllers([moviesViewController], animated: true)
        }
    }
    
    func showMenu() {
        parentCoordinator?.showMenu()
    }
    
    func checkDataSource() -> APIService {
        switch dataMenager.dataSource() {
        case "APIServiceTmbd":
            return APIServiceTmbd()
        case "APIServiceKinopoisk":
            return APIServiceKinopoisk()
        default:
           return APIServiceTmbd()
        }
    }
    
}
