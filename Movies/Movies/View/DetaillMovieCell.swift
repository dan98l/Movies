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
    @IBOutlet private weak var background: UIImageView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var overview: UILabel!
    @IBOutlet var average: StarShape!
    
    // MARK: - Properties
    var movieData: Data? {
        didSet {
            if let movieData = movieData {
                movieImageView.image = UIImage(data: movieData)
                background.image = UIImage(data: movieData)
            } else {
                movieImageView.image = UIImage(named: "noimage")
                background.image = nil
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
    
    var movieOverview: String? {
        didSet {
            if let movieOverview = movieOverview {
                overview.text = movieOverview
            } else {
                overview.text  = "No description"
            }
        }
    }
    
    var fillArea: Double? {
        didSet {
            if let fillArea = fillArea {
                average.fillArea = CGFloat(fillArea / 10)
            }
        }
    }
    
    var beams: Int? {
        didSet {
            if let beams = beams {
                average.beams = beams
            }
        }
    }
}
