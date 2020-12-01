//
//  SettingsViewModel.swift
//  Movies
//
//  Created by Daniil G on 18.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

protocol SettingsViewModelDelegate: class {
    func updateListMovies()
    func updateDataSource(index: Int)
    func getIndexForSegmentedControl() -> Int
}

class SettingsViewModel {
    
    // MARK: - Properties
    weak var delegate: SettingsViewModelDelegate?
    var dataMenager = DataManager()
    
    func changeDataSource(indexSegmentedControl: Int) {
        delegate?.updateDataSource(index: indexSegmentedControl)
        delegate?.updateListMovies()
    }
    
    func setSegmentedControl() -> Int {
        if let delegate = delegate {
            return delegate.getIndexForSegmentedControl()
        }
        return 0
    }
}
