//
//  Movie.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.


import Foundation

struct Movie: Decodable {
    let results: [Movies]
}

struct Movies: Decodable {
    let idMovies: Int?
    let posterPath: String?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
}
