//
//  ViewController.swift
//  Movies
//
//  Created by Daniil G on 12.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var popularMovies = [Movie]()
    
    private let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=afb20793e1a7d571016fad7cdd7d6075&language=en-US&page=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("start")
        
        APIService.getMoviesData(urlString: popularMoviesURL) { [weak self] result in
            print(result)
            DispatchQueue.main.async {
                switch result {
                case .success(let moviesList):
                    self?.popularMovies = moviesList.results
                case .failure(let error):
                    print("Error json: \(error)")
                }
            }
        }
    
    }

}
