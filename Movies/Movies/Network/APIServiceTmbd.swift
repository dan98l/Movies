//
//  APIServiceTmbd.swift
//  Movies
//
//  Created by Daniil G on 18.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation
import Alamofire

class APIServiceTmbd: APIService {
    
    // MARK: - Properties
    private var urlString = "https://api.themoviedb.org/3/movie/popular?api_key=afb20793e1a7d571016fad7cdd7d6075&language=en-US&page=1"
    private var urlImageString = "https://image.tmdb.org/t/p/w500"
    
    var popularMoviesTmbd: [MovieTmbd] = []
    var popularMovies: [Movies] = []
    
    func getMoviesData(completion: @escaping () -> Void) {
        AF.request(urlString).responseJSON { res in
            guard let data = res.data else { return }
            do {
                let movies = try JSONDecoder().decode(MoviesTmbd.self, from: data)
                self.popularMoviesTmbd = movies.results
                for item in movies.results {
                    let movie = Movies(idMovies: item.idMovies,
                                       posterPath: item.posterPath,
                                       title: item.title,
                                       voteAverage: item.voteAverage,
                                       overview: item.overview,
                                       releaseDate: item.releaseDate)
                    self.popularMovies.append(movie)
                }
                completion()
            } catch {
                
            }
        }
    }
    
    func getImageMovie(posterPath: String, completion: @escaping (Data) -> Void) {
        AF.request(urlImageString + posterPath).response { res in
            guard let data = res.data else { return }
            completion(data)
        }
    }
}
