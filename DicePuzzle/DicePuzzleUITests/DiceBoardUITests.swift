//
//  DicePuzzleUITests.swift
//  DicePuzzleUITests
//
//  Created by Marek Niedbach on 03.09.2017.
//  Copyright © 2017 Marek Niedbach. All rights reserved.
//

import XCTest
import DicePuzzle

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

    func testSwipingDices() {
        dice(at: 0, 0).swipeRight()
        dice(at: 1, 3).swipeLeft()
        dice(at: 2, 0).swipeRight()
        dice(at: 3, 3).swipeLeft()

        dice(at: 0, 0).swipeDown()
        dice(at: 3, 1).swipeUp()
        dice(at: 0, 2).swipeDown()
        dice(at: 3, 3).swipeUp()

        dice(at: 0, 0).swipeRight()
        dice(at: 0, 0).swipeRight()
        dice(at: 0, 0).swipeRight()
        dice(at: 0, 0).swipeRight()
        dice(at: 0, 0).swipeRight()
        dice(at: 0, 0).swipeRight()

        dice(at: 1, 0).swipeLeft()
        dice(at: 1, 0).swipeLeft()
        dice(at: 1, 0).swipeLeft()
        dice(at: 1, 0).swipeLeft()
        dice(at: 1, 0).swipeLeft()
        dice(at: 1, 0).swipeLeft()

        assert(row: 0, toBe: "3", "1", "3", "1")
        assert(row: 1, toBe: "1", "5", "1", "5")
        assert(row: 2, toBe: "3", "1", "3", "1")
        assert(row: 3, toBe: "1", "5", "1", "5")
    }

    private func assert(row: Int, toBe dices: String..., file: StaticString = #file, line: UInt = #line) {
        for col in 0..<dices.count {
            XCTAssertEqual(dice(at: row, col).value, dices[col], file: file, line: line)
        }
    }

    private func assert(col: Int, toBe dices: String..., file: StaticString = #file, line: UInt = #line) {
        for row in 0..<dices.count {
            XCTAssertEqual(dice(at: row, col).value, dices[row], file: file, line: line)
        }
    }

    private func dice(at row: Int, _ col: Int) -> XCUIElement {
        return app.otherElements["dice_\(row)_\(col)"]
    }
}

private extension XCUIElement {
    var value: String { return staticTexts.firstMatch.label }
}
