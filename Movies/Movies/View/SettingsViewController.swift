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
            viewModel.updateDataSource(indexSegmentedControl: sender.selectedSegmentIndex)
        }
    }
    @IBAction func stepperBeams(_ sender: Any) {
        stars.beams = Int(steperrBeams.value)
        if let viewModel = viewModel {
            viewModel.updateBeamsStars(beams: Int(steperrBeams.value))
        }
    }
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var steperrBeams: UIStepper!
    @IBOutlet weak var stars: StarShape!
    
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
            self.segmentControl.selectedSegmentIndex = model.segmentedControlIndex
            self.stars.beams = model.beamsStars
            self.steperrBeams.value = Double(model.beamsStars)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let model = viewModel {
            model.exitSettings()
        }
    }
}
