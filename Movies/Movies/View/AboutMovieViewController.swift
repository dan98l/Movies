//
//  AboutViewController.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class AboutMovieViewController: UIViewController {
    
    var viewModel: AboutMovieViewModel!
    
    static func instantiate() -> AboutMovieViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "AboutMovieViewController") as! AboutMovieViewController

        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
