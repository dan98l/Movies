//
//  APIServiceKinopoisk.swift
//  Movies
//
//  Created by Daniil G on 18.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation
import Alamofire

class APIServiceKinopoisk: APIService {
    
    // MARK: - Properties
    private var urlString = "https://api.kinopoisk.cloud/movies/all/page/666/token/66c34cdc9db6e03fc516ca92036617c0"

    var popularMoviesKinopoisk: [MovieKinopoisk] = []
    var searchMoviesKinopoisk: [MovieTmbd] = []
    var movies: [Movies] = []
    var popularMovies: [Movies] = []
    
    func getMoviesData(completion: @escaping () -> Void) {
       AF.request(urlString).responseJSON { res in
            guard let data = res.data else { return }
            do {
                let movies = try JSONDecoder().decode(MoviesKinopoisk.self, from: data)
                self.popularMoviesKinopoisk = movies.results
                
                for item in movies.results {
                    let movie = Movies(idMovies: Int(item.idMovies!),
                                       posterPath: item.posterPath,
                                       title: item.title,
                                       voteAverage: item.voteAverage,
                                       overview: item.overview,
                                       releaseDate: item.releaseDate)
                    self.movies.append(movie)
                    self.popularMovies.append(movie)
                }
                completion()
            } catch {
                
            }
        }
    }
    
    func getImageMovie(posterPath: String, completion: @escaping (Data) -> Void) {
        AF.request("https:" + posterPath).response { res in
            guard let data = res.data else { return }
            completion(data)
        }
    }
    
    func getSearchMovies(searchText: String, completion: @escaping ([Movies]) -> Void) {
    }
}

/*
keys: 
//cb4feb47794f420de1ed509cbc9ba038
//353adae387d51e7e97302a2eef43c29f
//ec5eb9bdc670d2e6f8d3ee8fdbb3ff4d
//39fab127531b2ab09cd680ac73616834
//66c34cdc9db6e03fc516ca92036617c0
*/
