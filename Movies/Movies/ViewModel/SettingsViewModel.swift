//
//  SettingsViewModel.swift
//  Movies
//
//  Created by Daniil G on 18.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

protocol SettingsViewModelDelegate: class {
    func updateListMoviesView()
    func changeDataSource(dataSource: Int?)
    func changeBeamsStars(beams: Int?)
}

class SettingsViewModel {
    // MARK: - Properties
    weak var delegate: SettingsViewModelDelegate?
    var segmentedControlIndex = 0
    var beamsStars = 1
    
    func updateDataSource(indexSegmentedControl: Int?) {
        if let indexSegmentedControl = indexSegmentedControl {
            delegate?.changeDataSource(dataSource: indexSegmentedControl)
        }
    }
    
    func updateBeamsStars(beams: Int?) {
        if let beams = beams {
            delegate?.changeBeamsStars(beams: beams)
        }
    }
    
    func exitSettings() {
        delegate?.updateListMoviesView()
    }
}
