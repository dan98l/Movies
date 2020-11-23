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
}

class SettingsViewModel {
    
    // MARK: - Properties
    weak var delegate: SettingsViewModelDelegate?
    var dataMenager = DataManager()
    
    func changeDataSourse(indexSegmentedControl: Int) {
        switch indexSegmentedControl {
        case 0:
            dataMenager.saveDaraSourse(dataSourse: "APIServiceTmbd")
        case 1:
            dataMenager.saveDaraSourse(dataSourse: "APIServiceKinopoisk")
        default: break
        }
        delegate?.updateListMovies()
    }
    
    func setSegmentedControl() -> Int {
        let apiName = dataMenager.getDataSourse()
        switch apiName {
        case "APIServiceTmbd":
            return 0
        case "APIServiceKinopoisk":
            return 1
        default: return 0
        }
    }
}
