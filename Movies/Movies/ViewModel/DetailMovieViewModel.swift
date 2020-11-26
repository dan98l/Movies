//
//  AboutMovieViewModel.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class DetailMovieViewModel {
    
    var movie: Movies!
    var imageMovie: UIImage?
    
    init(movie: Movies) {
        self.movie = movie
    }

}
