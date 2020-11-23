//
//  DataManager.swift
//  Movies
//
//  Created by Daniil G on 20.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

class DataManager {
    
    let api = APIServiceKinopoisk()
    
    func saveDaraSourse(dataSourse: String) {
        UserDefaults.standard.set(dataSourse as String, forKey: "dataSourse")
        UserDefaults.standard.synchronize()
        print("getDataSourse()", getDataSourse())
    }
    
    func getDataSourse() -> String {
        return  UserDefaults.standard.value(forKey: "dataSourse") as! String
    }
}
