//
//  AboutMovieViewModel.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

class DetailMovieViewModel {
    
    var movie: Movies?
    var apiService: APIService?
    
    init(movie: Movies, apiService: APIService) {
        self.movie = movie
        self.apiService = apiService
    }
    
    func movieTitle() -> String? {
        if let movie = movie, let title = movie.title {
            return title
        }
        return nil
    }
    
    func movieAverage() -> Double? {
        if let movie = movie, let average = movie.voteAverage {
            return average
        }
        return nil
    }
    
    func movieOverview() -> String? {
        if let movie = movie, let overview = movie.overview {
            return overview
        }
        return nil
    }
    
    func movieDate() -> String? {
        if let movie = movie, let date = movie.releaseDate {
            return date
        }
        return nil
    }
    
    func getImageData(completion: @escaping ((Data?) -> Void)) {
        if let movie = movie, let posterPath = movie.posterPath, let api = apiService {
            api.getImageData(posterPath: posterPath) { data in
                completion(data)
            }
        }
        completion(nil)
    }
}
