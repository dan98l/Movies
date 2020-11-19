//
//  AppCoordinator.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    private let navigationController = UINavigationController()
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let moviesCoordinator = MoviesCoordinator(navigationController: navigationController)
        moviesCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showSettingsView() {
        print("showSettingsView()")
    }
}
