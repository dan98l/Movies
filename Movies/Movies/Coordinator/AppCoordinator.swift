//
//  AppCoordinator.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit
import SideMenu

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator, MenuViewModelDelegate, SettingsViewModelDelegate {
  
    // MARK: - Properties
    private let navigationController = UINavigationController()
    private let window: UIWindow
    private var menu: SideMenuNavigationController?
    private let menuViewModel = MenuViewModel()
    var moviesCoordinator: MoviesCoordinator?
    var dataMenager = DataManager()
    
    init(window: UIWindow) {
        self.window = window
        menuViewModel.delegate = self
    }
    
    func start() {
        self.moviesCoordinator = MoviesCoordinator(navigationController: navigationController)
        if let moviesCoordinator = moviesCoordinator {
            moviesCoordinator.start()
            moviesCoordinator.parentCoordinator = self
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showSettingsOfView() {
        let showSettingViewController = SettingsViewController.instantiate()
        let moviesViewModel = SettingsViewModel()
        showSettingViewController.viewModel = moviesViewModel
        moviesViewModel.delegate = self
        
        navigationController.pushViewController(showSettingViewController, animated: true)
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func showMenu() {
        let showMenuViewController = MenuViewController.instantiate()
        showMenuViewController.viewModel = menuViewModel
      
        menu = SideMenuNavigationController(rootViewController: showMenuViewController)
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
    
        navigationController.present(menu!, animated: true)
    }
    
    func updateListMovies() {
        if let moviesCoordinator = moviesCoordinator {
            moviesCoordinator.updateMovieList()
        }
    }
    
    func updateDataSource(index: Int) {
        switch index {
        case 0:
            dataMenager.saveDataSource(dataSource: "APIServiceTmbd")
        case 1:
            dataMenager.saveDataSource(dataSource: "APIServiceKinopoisk")
        default: break
        }
    }
    
    func getIndexForSegmentedControl() -> Int {
        let apiName = dataMenager.dataSource()
        switch apiName {
        case "APIServiceTmbd":
             return 0
        case "APIServiceKinopoisk":
             return 1
        default: return 0
        }
      }
}
