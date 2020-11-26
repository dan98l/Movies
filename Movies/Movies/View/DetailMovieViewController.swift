//
//  AboutViewController.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieDate: UILabel!
    @IBOutlet private weak var movieAverage: UILabel!
    @IBOutlet private weak var movieOverview: UILabel!
    @IBOutlet private weak var movieTitle: UILabel!
    
    // MARK: - Properties
    var viewModel: DetailMovieViewModel!
    var movie: Movies!
    
    static func instantiate() -> DetailMovieViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailMovieViewController") as! DetailMovieViewController

        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = viewModel.movie.title {
            self.movieTitle.text = title
        }
        
        if let releaseDate = viewModel.movie.releaseDate {
            self.movieDate.text = releaseDate
        }
        
        if let average = viewModel.movie.voteAverage {
            self.movieAverage.text = String(average)
        }
        
        if let overview = viewModel.movie.overview {
            self.movieOverview.text = overview
        }
        
        if let image = viewModel.imageMovie {
            self.movieImageView.image = image
        }
    }
}