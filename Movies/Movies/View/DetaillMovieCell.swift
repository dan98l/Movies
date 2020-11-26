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
    var imageMovie: UIImage? {
        didSet {
            if let image = imageMovie {
                movieImageView.image = image
                movieImageViewForBluer.image = image
            }
        }
    }
    
    var title: String? {
        didSet {
            if let title = title {
                movieTitle.text = title
            } else {
                movieTitle.text = "No title"
            }
        }
    }
    
    var average: Double? {
        didSet {
            if let average = average {
                movieAverage.text = String(format: "%.1f", average)
            }
        }
    }
    
    var overview: String? {
        didSet {
            if let overview = overview {
                movieOverview.text = overview
            } else {
                movieOverview.text  = "No description"
            }
        }
    }
}
