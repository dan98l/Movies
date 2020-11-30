//
//  DetaillMovieCellModel.swift
//  Movies
//
//  Created by Daniil G on 30.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class DetaillMovieCellModel {
    var movie: Movies!
    var apiService: APIService!
    
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
    
    func getImageOfMovie(completion: @escaping ((UIImage?) -> Void)) {
       if let posterPath = movie.posterPath {
           apiService.getMovieImages(posterPath: posterPath) { data in
               completion(UIImage(data: data))
           }
       }
       completion(nil)
   }
}
