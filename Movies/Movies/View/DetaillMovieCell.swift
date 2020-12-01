//
//  DetailMovieCell.swift
//  Movies
//
//  Created by Daniil G on 18.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class DetaillMovieCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var movieImageViewForBluer: UIImageView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var average: UILabel!
    @IBOutlet private weak var overview: UILabel!
    
    // MARK: - Properties
    var movieData: Data? {
        didSet {
            if let movieData = movieData {
                movieImageView.image = UIImage(data: movieData)
                movieImageViewForBluer.image = UIImage(data: movieData)
            } else {
                movieImageView.image = UIImage(named: "noimage")
                movieImageViewForBluer.image = nil
            }
        }
    }
    
    var movieTitle: String? {
        didSet {
            if let movieTitle = movieTitle {
                title.text = movieTitle
            } else {
                title.text = "No title"
            }
        }
    }
    
    var movieAverage: Double? {
        didSet {
            if let movieAverage = movieAverage {
                average.text = String(format: "%.1f", movieAverage)
            }
        }
    }
    
    var movieOverview: String? {
        didSet {
            if let movieOverview = movieOverview {
                overview.text = movieOverview
            } else {
                overview.text  = "No description"
            }
        }
    }
}
