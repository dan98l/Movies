//
//  ShowMoviesViewModel.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

final class MoviesViewModel {
    
    var coordinator: MoviesCoordinator?
    
    func didTapMoview() {
        coordinator?.startMenu()
    }
    
}
