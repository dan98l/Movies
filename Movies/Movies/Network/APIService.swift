//
//  APISrerviceProtocol.swift
//  Movies
//
//  Created by Daniil G on 18.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

protocol APIService {
    var popularMovies: [Movies] { get }
    
    func getMoviesData(completion: @escaping () -> Void)
    func getImageMovie(posterPath: String, completion: @escaping (Data) -> Void)
}