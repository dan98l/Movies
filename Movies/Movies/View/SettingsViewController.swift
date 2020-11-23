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
    @IBAction func didChangeSegmentDataSours(_ sender: UISegmentedControl) {
        viewModel.changeDataSourse(indexSegmentedControl: sender.selectedSegmentIndex)
    }
    @IBOutlet weak var segmentControlDataSours: UISegmentedControl!
    
    // MARK: - Properties
    var viewModel: SettingsViewModel!
    
    static func instantiate() -> SettingsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController

        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentControlDataSours.selectedSegmentIndex = viewModel.setSegmentedControl()
    }
}
