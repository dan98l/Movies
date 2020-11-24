//
//  AboutMovieViewModel.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

protocol DitailMovieViewModelDelegate: class {
    
}

class DitailMovieViewModel {
    weak var delegate: DitailMovieViewModelDelegate?
    
    var movie: Movies!
    var dataImage: Data!
    
    init(movie: Movies) {
        self.movie = movie
    }

}
