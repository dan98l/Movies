//
//  AboutViewController.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class DitailMovieViewController: UIViewController {
    
    var viewModel: AboutMovieViewModel!
    
    static func instantiate() -> DitailMovieViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "DitailMovieViewController") as! DitailMovieViewController

        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
