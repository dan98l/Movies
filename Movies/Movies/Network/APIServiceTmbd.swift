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
    private var urlString = "https://api.themoviedb.org/3/movie/popular?api_key=afb20793e1a7d571016fad7cdd7d6075&language=en-US&page="
    private var urlStringWithoutPage = "https://api.themoviedb.org/3/search/movie?api_key=afb20793e1a7d571016fad7cdd7d6075&query="
    private var urlStringPage = "&page=1"
    private var urlImageString = "https://image.tmdb.org/t/p/w500"
    
    var popularMoviesTmbd: [MovieTmbd] = []
    var searchMoviesTmbd: [MovieTmbd] = []
    var popularMovies: [Movies] = []
    var movies: [Movies] = []
    
    func getMovies(indexPage: Int, completion: @escaping () -> Void) {
        AF.request(urlString + String(indexPage)).responseJSON { res in
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
                    self.movies.append(movie)
                    self.popularMovies.append(movie)
                }
                completion()
            } catch {
                
            }
        }
    }
    
    func getImageData(posterPath: String, completion: @escaping (Data) -> Void) {
        AF.request(urlImageString + posterPath).response { res in
            guard let data = res.data else { return }
            completion(data)
        }
    }
    
    func getImageDataSerial(posterPath: [String], completion: @escaping ([Data]) -> Void) {
        var dataImage = [Data]()
        DispatchQueue.init(label: "image").async {
            for poster in posterPath {
                if let url = URL(string: self.urlImageString + poster) {
                    if let data = try? Data(contentsOf: url) {
                        dataImage.append(data)
                    }
                }
            }
            completion(dataImage)
        }
    }
    
    func getMoviesSearch(searchText: String, completion: @escaping ([Movies]) -> Void) {
        self.movies = []
        AF.request(urlStringWithoutPage + searchText + urlStringPage).responseJSON { res in
            guard let data = res.data else { return }
            do {
                let movies = try JSONDecoder().decode(MoviesTmbd.self, from: data)
                self.searchMoviesTmbd = movies.results
                for item in movies.results {
                    let movie = Movies(idMovies: item.idMovies,
                                       posterPath: item.posterPath,
                                       title: item.title,
                                       voteAverage: item.voteAverage,
                                       overview: item.overview,
                                       releaseDate: item.releaseDate)
                    self.movies.append(movie)
                }
                completion(self.movies)
            } catch {
                
            }
        }
    }
       
}
