//
//  AboutMovieViewModel.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class DetailMovieViewModel {
    
    var movie: Movies?
    var apiService: APIService?
    
    init(movie: Movies, apiService: APIService) {
        self.movie = movie
        self.apiService = apiService
    }
    
    func getTitle() -> String? {
        if let movie = movie {
            if let title = movie.title {
                return title
            }
        }
        return nil
    }
    
    func getAverage() -> Double? {
        if let movie = movie {
            if let average = movie.voteAverage {
                return average
            }
        }
        return nil
    }
    
    func getOverview() -> String? {
        if let movie = movie {
            if let overview = movie.overview {
                return overview
            }
        }
        return nil
    }
    
    func getDate() -> String? {
        if let movie = movie {
            if let date = movie.releaseDate {
                return date
            }
        }
        return nil
    }
    
    func getImageOfMovie(completion: @escaping ((UIImage?) -> Void)) {
        if let movie = movie {
            if let posterPath = movie.posterPath {
                if let api = apiService {
                    api.getMovieImages(posterPath: posterPath) { data in
                        completion(UIImage(data: data))
                    }
                }
            }
        }
        completion(nil)
    }
}
