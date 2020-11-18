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
    @IBOutlet private weak var movieDate: UILabel!
    @IBOutlet private weak var movieAverage: UILabel!
    @IBOutlet private weak var movieOverview: UILabel!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var clickButton: UIButton!
    
    // MARK: - Properties
    var dataImage: Data?
    
    var movie: Movie! {
        didSet {
            updateMovieUI()
        }
    }
    
    private func updateMovieUI() {
        guard let title = movie.title else { return }
        self.movieTitle.text = title
        
        guard let average = movie.voteAverage else { return }
        self.movieAverage.text = String(average)
        
        guard let overview = movie.overview else { return }
        self.movieOverview.text = overview
        
        guard let data = dataImage else { return }
        if let image = UIImage(data: data) {
            self.movieImageView.image = image
        }
    }
}
