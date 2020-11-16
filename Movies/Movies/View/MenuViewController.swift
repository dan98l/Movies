//
//  MenuViewController.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    var viewModel: MenuViewModel!
    
    static func instantiate() -> AboutViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! AboutViewController

        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

/*
 //
    var menuViewController: UIViewController!
    var controller2: UIViewController!
    var isMove = false
    
    func configureMenuViewController() {
        if menuViewController == nil {
            menuViewController = MenuViewController()
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
        }
    }
    
    func showMenuViewController(shouldBool: Bool) {
        if shouldBool {
             UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller2.view.frame.origin.x = self.controller2.view.frame.width-140
             }) { (finished) in
                
            }
        } else {
            
        }
    }
 */
