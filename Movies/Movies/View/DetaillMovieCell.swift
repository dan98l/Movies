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
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieAverage: UILabel!
    @IBOutlet private weak var movieOverview: UILabel!
    
    // MARK: - Properties
    var viewModelCell: DetaillMovieCellModel!
    
    var imageOfMovie: UIImage? {
        didSet {
            if let image = imageOfMovie {
                movieImageView.image = image
                movieImageViewForBluer.image = image
            } else {
                movieImageView.image = UIImage(named: "noimage")
                movieImageViewForBluer.image = nil
            }
        }
    }
    
    var titleOfMovie: String? {
        didSet {
            if let title = titleOfMovie {
                movieTitle.text = title
            } else {
                movieTitle.text = "No title"
            }
        }
    }
    
    var averageOfMovie: Double? {
        didSet {
            if let average = averageOfMovie {
                movieAverage.text = String(format: "%.1f", average)
            }
        }
    }
    
    var overviewOfMovie: String? {
        didSet {
            if let overview = overviewOfMovie {
                movieOverview.text = overview
            } else {
                movieOverview.text  = "No description"
            }
        }
    }
    
    func setImageOfMovie(image: UIImage?, title: String?, overview: String?, voteAverage: Double?) {
        if title == titleOfMovie && overview == overviewOfMovie && voteAverage == averageOfMovie {
            movieImageView.image = image
            movieImageViewForBluer.image = image
        } else {
            movieImageView.image = UIImage(named: "noimage")
            movieImageViewForBluer.image = nil
        }
    }
}
