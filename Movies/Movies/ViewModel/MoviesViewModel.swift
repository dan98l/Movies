//
//  ShowMoviesViewModel.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

protocol MoviesViewModelDelegate: class {
    func showDetailMovie(index: Int)
    func showMenu()
}

final class MoviesViewModel {
    
    // MARK: - Properties
    var apiService: APIService!
    weak var delegate: MoviesViewModelDelegate?
    var movies: [Movies]!
    var statusOfLoadMovie = (loading: true, page: 1)
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getPopularMovies(indexPage: Int, completion: @escaping (() -> Void)) {
        statusOfLoadMovie.loading = false
        statusOfLoadMovie.page += 1
        apiService.getMoviesData(indexPage: indexPage, completion: {
            self.movies = self.apiService.movies
            completion()
            self.statusOfLoadMovie.loading = true
        })
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if let count = movies?.count {
            return count
        }
        return 0
    }
    
    func cellForRowAt (index: Int) -> Movies {
        return movies[index]
    }
    
    func  didTapMoviesCell(index: Int) {
        delegate?.showDetailMovie(index: index)
    }
    
    func didTapMenu() {
        delegate?.showMenu()
    }
    
    func getImageOfMovie(index: Int, completion: @escaping ((UIImage?, String?, String?, Double?) -> Void)) {
        if let posterPath = movies[index].posterPath {
            apiService.getMovieImages(posterPath: posterPath) { data in
                if let image = UIImage(data: data) {
                    completion(image, self.movies[index].title, self.movies[index].overview, self.movies[index].voteAverage)
                }
            }
        }
        completion(nil, nil, nil, nil)
    }
    
    func searchMovies(titleMovies: String, completion: @escaping (() -> Void)) {
        if titleMovies == "" {
            statusOfLoadMovie.loading = true
            self.movies = self.apiService.popularMovies
            completion()
        } else {
            statusOfLoadMovie.loading = false
            apiService.getMoviesSearch(searchText: titleMovies) { result in
                self.movies = result
                completion()
            }
        }
    }
    
    func getTitle(index: Int) -> String? {
        if let title = movies[index].title {
            return title
        }
        return nil
    }
    
    func getAverage(index: Int) -> Double? {
        if let average = movies[index].voteAverage {
            return average
        }
        return nil
    }
    
    func getOverview(index: Int) -> String? {
        if let overview = movies[index].overview {
            return overview
        }
        return nil
    }
    
    func getPosterPath(index: Int) -> String? {
        if let posterPath = movies[index].posterPath {
            return posterPath
        }
        return nil
    }
}
