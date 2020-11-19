//
//  MovieTmbd.swift
//  Movies
//
//  Created by Daniil G on 19.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

struct MoviesTmbd: Decodable {
    let results: [MovieTmbd]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct MovieTmbd: Decodable {
    let idMovies: Int?
    let posterPath: String?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case idMovies = "id"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.idMovies = try? container.decode(Int.self, forKey: .idMovies)
        self.title = try? container.decode(String.self, forKey: .title)
        self.voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        self.overview = try? container.decode(String.self, forKey: .overview)
        self.releaseDate = try? container.decode(String.self, forKey: .releaseDate)
    }
}
