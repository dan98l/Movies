//
//  ShowMoviesViewController.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var viewModel: MoviesViewModel!
    
    static func instantiate() -> MoviesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testButton()
    }

    func testButton() {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 140, height: 50))
        button.setTitleColor(.red, for: .normal)
        button.setTitle("About Movie", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        viewModel.didTapMoview()
    }
}
