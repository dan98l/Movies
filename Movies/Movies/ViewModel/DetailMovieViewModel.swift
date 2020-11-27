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
    
    func getTitle() -> String? {
        if let title = movie.title {
            return title
        }
        return nil
    }
    
    func getAverage() -> Double? {
        if let average = movie.voteAverage {
            return average
        }
        return nil
    }
    
    func getOverview() -> String? {
        if let overview = movie.overview {
            return overview
        }
        return nil
    }
    
    func getDate() -> String? {
        if let date = movie.releaseDate {
            return date
        }
        return nil
    }
}
