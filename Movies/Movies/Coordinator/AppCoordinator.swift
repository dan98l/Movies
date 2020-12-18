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
    var dataManager = DataManager()
    
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
        let settingViewModel = SettingsViewModel()
        showSettingViewController.viewModel = settingViewModel
        settingViewModel.delegate = self
        settingViewModel.segmentedControlIndex = getIndexForSegmentedControl()
         settingViewModel.beamsStars = getBeamsStars()
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
    
    func updateListMoviesView() {
        if let moviesCoordinator = moviesCoordinator {
            moviesCoordinator.updateMovieList()
        }
    }
    
    func changeDataSource(dataSource: Int?) {
        
        if let dataSource = dataSource {
            switch dataSource {
            case 0:
                dataManager.saveDataSource(dataSource: "APIServiceTmbd")
            case 1:
                dataManager.saveDataSource(dataSource: "APIServiceKinopoisk")
            default: break
            }
        }
    }
    
    func changeBeamsStars(beams: Int?) {
        if let beams = beams {
            dataManager.saveBeamsStars(beams: beams)
        }
    }
    
    func getIndexForSegmentedControl() -> Int {
        let apiName = dataManager.dataSource()
        switch apiName {
        case "APIServiceTmbd":
             return 0
        case "APIServiceKinopoisk":
             return 1
        default: return 0
        }
    }
    
    func getBeamsStars() -> Int {
        if let beams = dataManager.beamsStars() {
            return beams
        }
        return 2
    }
}
