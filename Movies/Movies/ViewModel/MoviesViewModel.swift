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
    var beamsStars: Int?
    
    weak var delegate: MoviesViewModelDelegate?
    var movies: [Movies]?
    var movieLoadStatus = (loading: true, page: 1)
    
    var urlStringForCheckImage = ""
    
    init(apiService: APIService, beamsStars: Int) {
        self.apiService = apiService
        self.beamsStars = beamsStars
    }
    
    func getPopularMovies(indexPage: Int, completion: @escaping (() -> Void)) {
        movieLoadStatus.loading = false
        movieLoadStatus.page += 1
        
        if let api = apiService {
            api.getMovies(indexPage: indexPage, completion: {
                self.movies = api.movies
                completion()
                self.movieLoadStatus.loading = true
            })
        }
    }
    
    func endScroll(completion: @escaping (() -> Void )) {
        getPopularMovies(indexPage: movieLoadStatus.page, completion: {
            completion()
        })
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
            movieLoadStatus.loading = true
            if let api = apiService {
                self.movies = api.popularMovies
            }
            completion()
        } else {
            movieLoadStatus.loading = false
            if let api = apiService {
                api.getMoviesSearch(searchText: titleMovies) { result in
                    self.movies = result
                    completion()
                }
            }
        }
    }
    
    func cellViewModel(index: Int) -> DetaillMovieCellModel {
        let viewModelCell = DetaillMovieCellModel()
        
        if let movies = movies {
            viewModelCell.movie = movies[index]
        }
        viewModelCell.apiService = apiService
        viewModelCell.beamsStars = beamsStars
        return viewModelCell
    }
}
