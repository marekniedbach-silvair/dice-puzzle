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
        swipeBoard(fromDiceAt: 0, 0, to: 0, 3)
        swipeBoard(fromDiceAt: 1, 3, to: 1, 0)
        swipeBoard(fromDiceAt: 2, 0, to: 2, 3)
        swipeBoard(fromDiceAt: 3, 3, to: 3, 0)

        swipeBoard(fromDiceAt: 0, 0, to: 3, 0)
        swipeBoard(fromDiceAt: 3, 1, to: 0, 1)
        swipeBoard(fromDiceAt: 0, 2, to: 3, 2)
        swipeBoard(fromDiceAt: 3, 3, to: 0, 3)

        swipeBoard(fromDiceAt: 0, 0, to: 0, 3)
        swipeBoard(fromDiceAt: 0, 0, to: 0, 3)
        swipeBoard(fromDiceAt: 0, 0, to: 0, 3)
        swipeBoard(fromDiceAt: 0, 0, to: 0, 3)
        swipeBoard(fromDiceAt: 0, 0, to: 0, 3)
        swipeBoard(fromDiceAt: 0, 0, to: 0, 3)

        swipeBoard(fromDiceAt: 1, 3, to: 1, 0)
        swipeBoard(fromDiceAt: 1, 3, to: 1, 0)
        swipeBoard(fromDiceAt: 1, 3, to: 1, 0)
        swipeBoard(fromDiceAt: 1, 3, to: 1, 0)
        swipeBoard(fromDiceAt: 1, 3, to: 1, 0)
        swipeBoard(fromDiceAt: 1, 3, to: 1, 0)

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

    private func swipeBoard(fromDiceAt startRow: Int, _ startCol: Int, to endRow: Int, _ endCol: Int) {
        dice(at: startRow, startCol).swipe(to: dice(at: endRow, endCol))
    }

    private func dice(at row: Int, _ col: Int) -> XCUIElement {
        return app.otherElements["dice_\(row)_\(col)"]
    }
}

private extension XCUIElement {
    var value: String { return staticTexts.firstMatch.label }

    func swipe(to element: XCUIElement) {
        press(forDuration: 0, thenDragTo: element)
    }
}
