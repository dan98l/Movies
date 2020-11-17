//
//  ShowMoviesViewModel.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

final class MoviesViewModel {
    
    var coordinator: MoviesCoordinator?
    let apiService = APIService(urlString: "https://api.themoviedb.org/3/movie/popular?api_key=afb20793e1a7d571016fad7cdd7d6075&language=en-US&page=1")
    
    private var popularMovies = [Movie]()
    
    func didTapMoview() {
        coordinator?.startAboutMovie()
    }
    
    func getPopularMovies(completion: @escaping (() -> Void)) {
        apiService.getMoviesData(completion: { [weak self] result in
            switch result {
            case .success(let moviesList):
                self?.popularMovies = moviesList.results
                completion()
            case .failure(let error):
                print("Error json: \(error)")
            }
        })
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
}
