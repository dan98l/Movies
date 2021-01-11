//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Daniil G on 08.01.2021.
//  Copyright © 2021 Daniil G. All rights reserved.
//

import XCTest

class MoviesUITests: XCTestCase {
    
    func testMoviesViewPageExists() throws {
        let page = MoviesViewPage(app: XCUIApplication())
        
        XCTAssertTrue(page.tableMovies.exists)
        XCTAssertTrue(page.collectionMovies.exists)
        XCTAssertTrue(page.tableMovies.cells.count > 0)
    }
    
    func testAction() throws {
        let page = MoviesViewPage(app: XCUIApplication())
        
        page.testSwipe()
        page.testSearchFields()
        page.testMenuSide()
    }
    
}
