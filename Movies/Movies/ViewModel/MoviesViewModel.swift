//
//  ShowMoviesViewModel.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

final class MoviesViewModel {
    
    // MARK: - Properties
    var coordinator: MoviesCoordinator?
    
    var apiService: APIService = APIServiceTmbd()
//    var apiService: APIService = APIServiceKinopoisk()
    
    func getPopularMovies(completion: @escaping (() -> Void)) {
        apiService.getMoviesData(completion: {
            completion()
        })
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if apiService.popularMovies.count != 0 {
            return apiService.popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt (index: Int) -> Movies {
        return apiService.popularMovies[index]
    }
    
    func didTapMoviesCell(idMovie: Int) {
        coordinator?.showDitailMovie()
    }
    
    func getImageMovie(indexPath: IndexPath, completion: @escaping ((Data) -> Void)) {
        guard let posterPath = apiService.popularMovies[indexPath.row].posterPath else { return }
        
        apiService.getImageMovie(posterPath: posterPath) { data in
            completion(data)
        }
    }
    
}

