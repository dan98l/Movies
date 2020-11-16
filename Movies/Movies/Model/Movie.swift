//
//  Movie.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

struct MovieResponsive: Decodable {
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Movie: Decodable {
    let posterPath: String?
    let idMovies: Int?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case idMovies = "id"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.idMovies = try? container.decode(Int.self, forKey: .idMovies)
        self.title = try? container.decode(String.self, forKey: .title)
        self.voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        self.overview = try? container.decode(String.self, forKey: .overview)
        self.releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        self.backdropPath = try? container.decode(String.self, forKey: .backdropPath)
    }
}
