//
//  APIService.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

class APIService {
    
    class func getMoviesData(urlString: String, completion: @escaping (Result<MovieResponsive, Error>) -> Void) {
            
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            print(data)
            do {

                let jsonData = try JSONDecoder().decode(MovieResponsive.self, from: data)
                completion(.success(jsonData))

            } catch let error {
                completion(.failure(error))
            }
                
        }.resume()
    }
}
