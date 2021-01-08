//
//  DataManager.swift
//  Movies
//
//  Created by Daniil G on 20.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

class DataManager {
    
    func saveDataSource(dataSource: String) {
        UserDefaults.standard.set(dataSource as String, forKey: "dataSource")
        UserDefaults.standard.synchronize()
    }
    
    func saveBeamsStars(beams: Int) {
        UserDefaults.standard.set(beams as Int, forKey: "beamsStars")
        UserDefaults.standard.synchronize()
    }
    
    func dataSource() -> String? {
        if let answer = UserDefaults.standard.value(forKey: "dataSource") {
            return answer as? String
        }
        return nil
    }
    
    func beamsStars() -> Int? {
        if let answer = UserDefaults.standard.value(forKey: "beamsStars") {
            return answer as? Int
        }
        return 5
    }
}
