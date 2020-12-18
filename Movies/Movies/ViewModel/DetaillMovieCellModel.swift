//
//  DetaillMovieCellModel.swift
//  Movies
//
//  Created by Daniil G on 30.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class DetaillMovieCellModel {
    var movie: Movies?
    var apiService: APIService?
    var beamsStars: Int?
    
    func movieTitle() -> String? {
        if let movie = movie {
            return movie.title
        }
        return nil
    }
    
    func movieAverage() -> Double? {
        if let movie = movie {
            return movie.voteAverage
        }
        return nil
    }
    
    func movieOverview() -> String? {
        if let movie = movie {
            return movie.overview
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
