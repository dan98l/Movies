//
//  MoviesCollectionCell.swift
//  Movies
//
//  Created by Daniil G on 18.12.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class MoviesCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var background: UIImageView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var overview: UILabel!
    @IBOutlet var average: StarShape!
    
    // MARK: - Properties
    var movieTitle: String? {
        didSet {
            if let movieTitle = movieTitle {
                title.text = movieTitle
            } else {
                title.text = "No title"
            }
        }
    }
    
    var imageData: Data? {
        didSet {
            if let imageData = imageData {
                background.image = UIImage(data: imageData)
                movieImageView.image = UIImage(data: imageData)
            } else {
                background.image = UIImage(named: "noimage")
                movieImageView.image = UIImage(named: "noimage")
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
}
