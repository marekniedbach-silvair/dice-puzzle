//
//  BoardSwapperTests.swift
//  DicePuzzleTests
//
//  Created by Marek Niedbach on 29/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import XCTest
@testable import DicePuzzle


protocol SwappableBoard {
    func swap(rowAt row: Int, direction: DiceSwapDirection)
}

class DiceBoardMock: SwappableBoard {
    var swappedRow: Int?
    var swappedDirection: DiceSwapDirection?

    func swap(rowAt row: Int, direction: DiceSwapDirection) {
        swappedRow = row
        swappedDirection = direction
    }
}

class BoardSwapper {
    private let board: SwappableBoard
    private var beginPosition = DicePosition(row: 0, col: 0)

    init(board: SwappableBoard) {
        self.board = board
    }

    func begin(at position: DicePosition) {
        beginPosition = position
    }

    func end(at position: DicePosition) {
        if position.row == beginPosition.row {
            if position.col > beginPosition.col {
                board.swap(rowAt: position.row, direction: .forward)
            } else if position.col < beginPosition.col {
                board.swap(rowAt: position.row, direction: .backward)
            }
        }
    }
}

class BoardSwapperTests: XCTestCase {
    private let board = DiceBoardMock()
    private lazy var sut = BoardSwapper(board: board)

    func testSwapRowForward() {
        sut.begin(at: DicePosition(row: 4, col: 1))
        sut.end(at: DicePosition(row: 4, col: 5))

        XCTAssertEqual(board.swappedRow, 4)
        XCTAssertEqual(board.swappedDirection, .forward)
    }

    func testSwapRowBackward() {
        sut.begin(at: DicePosition(row: 5, col: 4))
        sut.end(at: DicePosition(row: 5, col: 2))

        XCTAssertEqual(board.swappedRow, 5)
        XCTAssertEqual(board.swappedDirection, .backward)
    }

    func testDontSwapRowIfPositionNotChanged() {
        sut.begin(at: DicePosition(row: 3, col: 1))
        sut.end(at: DicePosition(row: 3, col: 1))

        XCTAssertNil(board.swappedRow)
    }

    func testDontSwapRowForwardIfRowChanged() {
        sut.begin(at: DicePosition(row: 1, col: 2))
        sut.end(at: DicePosition(row: 2, col: 5))

        XCTAssertNil(board.swappedRow)
    }

    func testDontSwapRowBackwardIfRowChanged() {
        sut.begin(at: DicePosition(row: 1, col: 5))
        sut.end(at: DicePosition(row: 2, col: 2))

        XCTAssertNil(board.swappedRow)
    }
}
