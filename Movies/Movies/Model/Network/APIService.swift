//
//  APIService.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    private var urlString = ""
    private var urlImageString = "https://image.tmdb.org/t/p/w500"

    init(urlString: String) {
        self.urlString = urlString
    }
    
    func getMoviesData(completion: @escaping (Result<MovieResponsive, Error>) -> Void) {
        
        AF.request(urlString).responseJSON { (res) in
            guard let data = res.data else { return }
            do {
                let movies = try JSONDecoder().decode(MovieResponsive.self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getImageMovie(posterPath: String, completion: @escaping (Data) -> Void) {
        AF.request(urlImageString + posterPath).response { res in
            guard let data = res.data else { return }
            completion(data)
        }
    }
}
