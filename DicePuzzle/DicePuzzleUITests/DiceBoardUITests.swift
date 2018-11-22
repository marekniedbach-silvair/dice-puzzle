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
        assert(row: 0, toBe: "1", "1", "1", "1")
        assert(row: 1, toBe: "1", "1", "1", "1")
        assert(row: 2, toBe: "1", "1", "1", "1")
        assert(row: 3, toBe: "1", "1", "1", "1")

        dice(at: 0, 0).swipeRight()
        assert(row: 0, toBe: "2", "2", "2", "2")

        dice(at: 0, 3).swipeLeft()
        assert(row: 0, toBe: "1", "1", "1", "1")

        dice(at: 1, 1).swipeRight()
        assert(row: 1, toBe: "2", "2", "2", "2")

        dice(at: 1, 2).swipeLeft()
        assert(row: 1, toBe: "1", "1", "1", "1")

        dice(at: 2, 2).swipeRight()
        assert(row: 2, toBe: "2", "2", "2", "2")

        dice(at: 2, 2).swipeLeft()
        assert(row: 2, toBe: "1", "1", "1", "1")

        dice(at: 3, 3).swipeRight()
        assert(row: 3, toBe: "2", "2", "2", "2")

        dice(at: 3, 0).swipeLeft()
        assert(row: 3, toBe: "1", "1", "1", "1")

        dice(at: 0, 0).swipeDown()
        assert(col: 0, toBe: "2", "2", "2", "2")

        dice(at: 3, 0).swipeUp()
        assert(col: 0, toBe: "1", "1", "1", "1")

        dice(at: 1, 1).swipeDown()
        assert(col: 1, toBe: "2", "2", "2", "2")

        dice(at: 2, 1).swipeUp()
        assert(col: 1, toBe: "1", "1", "1", "1")

        dice(at: 2, 2).swipeDown()
        assert(col: 2, toBe: "2", "2", "2", "2")

        dice(at: 1, 2).swipeUp()
        assert(col: 2, toBe: "1", "1", "1", "1")

        dice(at: 3, 3).swipeDown()
        assert(col: 3, toBe: "2", "2", "2", "2")

        dice(at: 0, 3).swipeUp()
        assert(col: 3, toBe: "1", "1", "1", "1")
    }

//    func testSwipeDexterFromTopLeftToRightBottom() {
//        dice(at: 0, 0).press(forDuration: 0, thenDragTo: dice(at: 3, 3))
//        assert(row: 0, toBe: "2", "1", "1", "1")
//        assert(row: 1, toBe: "1", "2", "1", "1")
//        assert(row: 2, toBe: "1", "1", "2", "1")
//        assert(row: 3, toBe: "1", "1", "1", "2")
//    }

    private func assert(row: Int, toBe dices: String..., file: StaticString = #file, line: UInt = #line) {
        for i in 0..<dices.count {
            XCTAssertEqual(dice(at: row, i).value, dices[i], file: file, line: line)
        }
    }

    private func assert(col: Int, toBe dices: String..., file: StaticString = #file, line: UInt = #line) {
        for i in 0..<dices.count {
            XCTAssertEqual(dice(at: i, col).value, dices[i], file: file, line: line)
        }
    }

    private func dice(at row: Int, _ col: Int) -> XCUIElement {
        return app.otherElements["dice_\(row)_\(col)"]
    }
}

private extension XCUIElement {
    var value: String { return staticTexts.firstMatch.label }
}
