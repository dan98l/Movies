//
//  MenuViewModel.swift
//  Movies
//
//  Created by Daniil G on 17.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

protocol MenuViewModelDelegate: class {
    func showSettingsView()
}

class MenuViewModel {
    
   weak var delegate: MenuViewModelDelegate?
    
    func didTapSettings() {
        delegate?.showSettingsView()
    }
}
