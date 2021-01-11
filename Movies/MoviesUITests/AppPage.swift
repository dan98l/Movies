//
//  AppPage.swift
//  MoviesUITests
//
//  Created by Daniil G on 10.01.2021.
//  Copyright © 2021 Daniil G. All rights reserved.
//

import XCTest

class AppPage {
    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
        app.launch()
    }
}
