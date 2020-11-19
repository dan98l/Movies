//
//  DitailMovieCell.swift
//  Movies
//
//  Created by Daniil G on 18.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class DitailMovieCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieAverage: UILabel!
    @IBOutlet private weak var movieOverview: UILabel!
    
    // MARK: - Properties
    var dataImage: Data?
    
    var movie: Movies! {
        didSet {
            updateMovieUI()
        }
    }
    
    private func updateMovieUI() {
        
        if let title = movie.title {
            self.movieTitle.text = title
        }
        
        if let average = movie.voteAverage {
            self.movieAverage.text = String(format: "%.1f", average)
        }
        
        if let overview = movie.overview {
            self.movieOverview.text = overview
        }
        
        guard let data = dataImage else { return }
        if let image = UIImage(data: data) {
            self.movieImageView.image = image
        }
    }
}
