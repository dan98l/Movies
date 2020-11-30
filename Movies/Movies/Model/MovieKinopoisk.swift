//
//  MovieKinopoisk.swift
//  Movies
//
//  Created by Daniil G on 19.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

struct MoviesKinopoisk: Decodable {
    let results: [MovieKinopoisk]
    
    enum CodingKeys: String, CodingKey {
        case results = "movies"
    }
}

struct MovieKinopoisk: Decodable {
    let idMovies: Int?
    let posterPath: String?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster"
        case idMovies = "id_kinopoisk"
        case title
        case voteAverage = "rating_kinopoisk"
        case overview = "description"
        case releaseDate = "premiere_world"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.idMovies = try? container.decode(Int.self, forKey: .idMovies)
        self.title = try? container.decode(String.self, forKey: .title)
        self.overview = try? container.decode(String.self, forKey: .overview)
        self.releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        
        do {
            voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        } catch DecodingError.typeMismatch {
            voteAverage = Double(try container.decode(String.self, forKey: .voteAverage))
        }
    }
}
