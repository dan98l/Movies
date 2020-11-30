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
        
        if let model = viewModel {
            movieTitle.text = model.getTitle()
            
            movieDate.text = model.getDate()
            
            movieAverage.text = String(format: "%.1f", model.getAverage()!)
            
            movieOverview.text = model.getOverview()
            
            model.getImageOfMovie { image in
                if let image = image {
                    self.movieImageView.image = image
                } else {
                    self.movieImageView.image = UIImage(named: "noimage")
                }
            }
        }
    }
}
