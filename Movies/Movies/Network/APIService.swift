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
    var movies: [Movies] { get }
    func getMoviesData(indexPage: Int, completion: @escaping () -> Void)
    func getMovieImages(posterPath: String, completion: @escaping (Data) -> Void)
    func getMoviesSearch(searchText: String, completion: @escaping ([Movies]) -> Void)
}
