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
    var viewModel: DetailMovieViewModel?
    
    static func instantiate() -> DetailMovieViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailMovieViewController") as! DetailMovieViewController

        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel {
            movieTitle.text = viewModel.movieTitle()
            movieDate.text = viewModel.movieDate()
            movieAverage.text = String(format: "%.1f", viewModel.movieAverage()!)
            movieOverview.text = viewModel.movieOverview()
            
            viewModel.getImageData { data in
                if let data = data {
                    self.movieImageView.image = UIImage(data: data)
                } else {
                    self.movieImageView.image = UIImage(named: "noimage")
                }
            }
        }
    }
}
