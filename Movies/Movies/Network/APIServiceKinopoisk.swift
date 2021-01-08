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
    private var urlStringWithoutPage = "https://api.kinopoisk.cloud/movies/all/page/"
    private var urlStringPartToken = "/token/ec5eb9bdc670d2e6f8d3ee8fdbb3ff4d"
    var popularMoviesKinopoisk: [MovieKinopoisk] = []
    var searchMoviesKinopoisk: [MovieTmbd] = []
    var movies: [Movies] = []
    var popularMovies: [Movies] = []
    
    func getMovies(indexPage: Int, completion: @escaping () -> Void) {
       AF.request(urlStringWithoutPage + String(indexPage) + urlStringPartToken).responseJSON { res in
            guard let data = res.data else { return }
            do {
                let movies = try JSONDecoder().decode(MoviesKinopoisk.self, from: data)
                self.popularMoviesKinopoisk = movies.results
                
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
        AF.request("https:" + posterPath).response { res in
            guard let data = res.data else { return }
            completion(data)
        }
    }
    
    func getImageDataSerial(posterPath: [String], completion: @escaping ([Data]) -> Void) {
        
        var dataImage = [Data]()
        DispatchQueue.init(label: "image").async {
            for poster in posterPath {
                if let url = URL(string: "https:" + poster) {
                    if let data = try? Data(contentsOf: url) {
                        dataImage.append(data)
                    }
                }
            }
            completion(dataImage)
        }
    }
    
    func getMoviesSearch(searchText: String, completion: @escaping ([Movies]) -> Void) {
        // This API does not allow using this method
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
