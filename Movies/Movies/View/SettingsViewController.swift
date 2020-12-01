//
//  SettingsViewController.swift
//  Movies
//
//  Created by Daniil G on 18.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBAction func didChangeSegmentDataSource(_ sender: UISegmentedControl) {
        if let viewModel = viewModel {
            viewModel.changeDataSource(indexSegmentedControl: sender.selectedSegmentIndex)
        }
    }
    @IBOutlet weak var segmentControlDataSource: UISegmentedControl!
    
    // MARK: - Properties
    var viewModel: SettingsViewModel?
    
    static func instantiate() -> SettingsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model = viewModel {
            self.segmentControlDataSource.selectedSegmentIndex = model.setSegmentedControl()
        }
    }
}
