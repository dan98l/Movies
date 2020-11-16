//
//  ShowMoviesViewController.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import SideMenu
import UIKit

class MoviesViewController: UIViewController {
    
    var viewModel: MoviesViewModel!
    var menu: SideMenuNavigationController?
    
    static func instantiate() -> MoviesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = SideMenuNavigationController(rootViewController: UIViewController())
        menu?.leftSide = true
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
         
        setNavigationController()
        testButton()
    }

    private func setNavigationController() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Movies"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal),
        style: .plain, target: self, action: #selector(didTapLeftBarButton))
    }
    
    func testButton() {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 140, height: 50))
        button.setTitleColor(.red, for: .normal)
        button.setTitle("About Movie", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(button)
    }
    
    @objc func didTapLeftBarButton() {
        present(menu!, animated: true)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        viewModel.didTapMoview()
    }
}
