//
//  ShowMoviesViewModel.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

protocol MoviesViewModelDelegate: class {
    func showDetailMovie(index: Int)
    func showMenu()
}

final class MoviesViewModel {
    
    // MARK: - Properties
    var apiService: APIService?
    
    weak var delegate: MoviesViewModelDelegate?
    var movies: [Movies]?
    var statusOfLoadMovie = (loading: true, page: 1)
    
    var urlStringForCheckImage = ""
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getPopularMovies(indexPage: Int, completion: @escaping (() -> Void)) {
        statusOfLoadMovie.loading = false
        statusOfLoadMovie.page += 1
        
        if let api = apiService {
            api.getMoviesData(indexPage: indexPage, completion: {
                self.movies = api.movies
                completion()
                self.statusOfLoadMovie.loading = true
            })
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if let count = movies?.count {
            return count
        }
        return 0
    }
    
    func cellForRowAt (index: Int) -> Movies? {
        if let movies = movies {
            return movies[index]
        }
        return nil
    }
    
    func  didTapMoviesCell(index: Int) {
        delegate?.showDetailMovie(index: index)
    }
    
    func didTapMenu() {
        delegate?.showMenu()
    }
    
    func searchMovies(titleMovies: String, completion: @escaping (() -> Void)) {
        if titleMovies == "" {
            statusOfLoadMovie.loading = true
            if let api = apiService {
                self.movies = api.popularMovies
            }
            completion()
        } else {
            statusOfLoadMovie.loading = false
            if let api = apiService {
                api.getMoviesSearch(searchText: titleMovies) { result in
                    self.movies = result
                    completion()
                }
            }
        }
    }
    
    func getTitle(index: Int) -> String? {
        if let movies = movies, let title = movies[index].title {
            return title
        }
        return nil
    }
    
    func getAverage(index: Int) -> Double? {
        if let movies = movies, let average = movies[index].voteAverage {
            return average
        }
        return nil
    }
    
    func getOverview(index: Int) -> String? {
        if let movies = movies, let overview = movies[index].overview {
            return overview
        }
        return nil
    }
    
    func getPosterPath(index: Int) -> String? {
        if let movies = movies, let posterPath = movies[index].posterPath {
            return posterPath
        }
        return nil
    }
    
    func cellViewModel(index: Int) -> DetaillMovieCellModel {
        let viewModelCell = DetaillMovieCellModel()
        if let movies = movies, let apiService = apiService {
            viewModelCell.movie = movies[index]
            viewModelCell.apiService = apiService
        }
        return viewModelCell
    }
}
