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
    func getMovies(indexPage: Int, completion: @escaping () -> Void)
    func getImageData(posterPath: String, completion: @escaping (Data) -> Void)
    func getMoviesSearch(searchText: String, completion: @escaping ([Movies]) -> Void)
    func getImageDataSerial(posterPath: [String], completion: @escaping ([Data]) -> Void)
}
