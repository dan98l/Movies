//
//  MoviesViewPage.swift
//  MoviesUITests
//
//  Created by Daniil G on 10.01.2021.
//  Copyright © 2021 Daniil G. All rights reserved.
//

import XCTest

class MoviesViewPage: AppPage {
    
    var tableMovies: XCUIElement {
        app.tables["movieTable"]
    }
    
    var collectionMovies: XCUIElement {
        app.tables["movieTable"].cells["movieCell"]
    }
    
    // MARK: - Actions
    
    func tapMovie() {
        app.tables["movieTable"].cells["movieCell"].tap()
    }
    
    func testSwipe() {
        app.swipeUp()
        app.swipeUp()
        app.swipeDown()
        app.swipeDown()
    }
    
    func testMenuSide() {
        app.navigationBars.buttons["Menu"].tap()
    }
    
    func testSearchFields() {
        app.navigationBars["Movies.MoviesView"].searchFields["Enter your search here"].tap()
        app.navigationBars["Movies.MoviesView"].searchFields["Enter your search here"].typeText("Pirates of the ")

    }
}
