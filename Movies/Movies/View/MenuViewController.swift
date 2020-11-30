//
//  MenuViewController.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: MenuViewModel?
    private var menuTableView: UITableView?

    static func instantiate() -> MenuViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController

        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationController()
        setTableView()
    }
    
    private func setTableView() {
        
        let barHeight: CGFloat = {
            var heightToReturn: CGFloat = 0.0
                 for window in UIApplication.shared.windows {
                     if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                         heightToReturn = height
                     }
                 }
            return heightToReturn
        }()
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        menuTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        if let menuTable = menuTableView {
            menuTable.dataSource = self
            menuTable.delegate = self
            menuTable.separatorStyle = UITableViewCell.SeparatorStyle.none
            menuTable.backgroundColor = .darkGray
            
            menuTable.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
            
            self.view.addSubview(menuTable)
        }
    }
    
    private func setNavigationController() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = viewModel {
            model.didTapSettings()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.textLabel?.text = "Settings"
        cell.selectionStyle = .none
        
        return cell
    }
}
