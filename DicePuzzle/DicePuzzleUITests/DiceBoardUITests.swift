//
//  DicePuzzleUITests.swift
//  DicePuzzleUITests
//
//  Created by Marek Niedbach on 03.09.2017.
//  Copyright © 2017 Marek Niedbach. All rights reserved.
//

import XCTest

class DiceBoardUITests: XCTestCase {

    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app.launch()
    }

    func testShowDiceBoardAtLaunch() {
        XCTAssertTrue(app.navigationBars["Dice Puzzle"].exists)
    }

    func testShowDicesWithInitialValues() {
        XCTAssertEqual(dice(at: 0, 0).value, "1")
        XCTAssertEqual(dice(at: 0, 1).value, "1")
        XCTAssertEqual(dice(at: 0, 2).value, "1")
        XCTAssertEqual(dice(at: 0, 3).value, "1")

        XCTAssertEqual(dice(at: 1, 0).value, "1")
        XCTAssertEqual(dice(at: 1, 1).value, "1")
        XCTAssertEqual(dice(at: 1, 2).value, "1")
        XCTAssertEqual(dice(at: 1, 3).value, "1")

        XCTAssertEqual(dice(at: 2, 0).value, "1")
        XCTAssertEqual(dice(at: 2, 1).value, "1")
        XCTAssertEqual(dice(at: 2, 2).value, "1")
        XCTAssertEqual(dice(at: 2, 3).value, "1")

        XCTAssertEqual(dice(at: 3, 0).value, "1")
        XCTAssertEqual(dice(at: 3, 1).value, "1")
        XCTAssertEqual(dice(at: 3, 2).value, "1")
        XCTAssertEqual(dice(at: 3, 3).value, "1")
    }

    func testSwipeFirstRowRightShouldIncreaseDiceValues() {
        dice(at: 0, 0).swipeRight()
        XCTAssertEqual(dice(at: 0, 0).value, "2")
        XCTAssertEqual(dice(at: 0, 1).value, "2")
        XCTAssertEqual(dice(at: 0, 2).value, "2")
        XCTAssertEqual(dice(at: 0, 3).value, "2")

        dice(at: 0, 0).swipeRight()
        XCTAssertEqual(dice(at: 0, 0).value, "3")
        XCTAssertEqual(dice(at: 0, 1).value, "3")
        XCTAssertEqual(dice(at: 0, 2).value, "3")
        XCTAssertEqual(dice(at: 0, 3).value, "3")
    }

    private func dice(at row: Int, _ col: Int) -> XCUIElement {
        return app.otherElements["dice_\(row)_\(col)"]
    }
}

private extension XCUIElement {
    var value: String { return staticTexts.firstMatch.label }
}
