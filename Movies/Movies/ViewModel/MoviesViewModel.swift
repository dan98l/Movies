//
//  ShowMoviesViewModel.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

protocol MoviesViewModelDelegate: class {
    func showDitailMovie(index: Int)
    func showMenu()
}

final class MoviesViewModel {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    var apiService: APIService!
    weak var delegate: MoviesViewModelDelegate?
    var movies: [Movies]!
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getPopularMovies(completion: @escaping (() -> Void)) {
        apiService.getMoviesData(completion: {
            self.movies = self.apiService.movies
            completion()
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
        delegate?.showDitailMovie(index: index)
    }
    
    func didTapMenu() {
        delegate?.showMenu()
    }
    
    func getImageMovie(index: Int, completion: @escaping ((Data, String) -> Void)) {
        guard let posterPath = movies[index].posterPath else { return }
        
        apiService.getImageMovie(posterPath: posterPath) { data in
            completion(data, posterPath)
        }
    }
    
    func searchMovies(titleMovies: String, completion: @escaping (() -> ())) {
        if titleMovies == "" {
            self.movies = self.apiService.popularMovies
            completion()
        } else {
            apiService.getSearchMovies(searchText: titleMovies) { result in
                self.movies = result
                completion()
            }
        }
    }
}
