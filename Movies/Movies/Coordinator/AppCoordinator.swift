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

class AppCoordinator: Coordinator, MenuViewModelDelegate {
    
    // MARK: - Properties
    private let navigationController = UINavigationController()
    private let window: UIWindow
    private var menu: SideMenuNavigationController?
    private let menuViewModel = MenuViewModel()
    
    init(window: UIWindow) {
        self.window = window
        menuViewModel.delegate = self
    }
    
    func start() {
        let moviesCoordinator = MoviesCoordinator(navigationController: navigationController)
        moviesCoordinator.start()
        moviesCoordinator.parentCoordinator = self
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showSettingsView() {
        let showSettingViewController = SettingsViewController.instantiate()
        showSettingViewController.viewModel = SettingsViewModel()
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
}
