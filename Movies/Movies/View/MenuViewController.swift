//
//  MenuViewController.swift
//  Movies
//
//  Created by Daniil G on 16.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var viewModel = MenuViewModel()
    private var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationController()
        setBackgroundColor()
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
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        menuTableView.backgroundColor = .darkGray
        self.view.addSubview(menuTableView)
    }
    
    private func setNavigationController() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setBackgroundColor() {
        self.view.backgroundColor = .red
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapSettings()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath as IndexPath)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.textLabel?.text = "Settings"
        cell.selectionStyle = .none
        
        return cell
    }
}
