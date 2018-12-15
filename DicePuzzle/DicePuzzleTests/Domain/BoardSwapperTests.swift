//
//  Created by Marek Niedbach on 29/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import XCTest
@testable import DicePuzzle

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

    func testSwapColumnForward() {
        sut.begin(at: DicePosition(row: 1, col: 1))
        sut.end(at: DicePosition(row: 4, col: 1))

        XCTAssertEqual(board.swappedCol, 1)
        XCTAssertEqual(board.swappedDirection, .forward)
    }

    func testSwapColumnBackward() {
        sut.begin(at: DicePosition(row: 3, col: 3))
        sut.end(at: DicePosition(row: 2, col: 3))

        XCTAssertEqual(board.swappedCol, 3)
        XCTAssertEqual(board.swappedDirection, .backward)
    }

    func testDontSwapIfPositionNotChanged() {
        sut.begin(at: DicePosition(row: 3, col: 1))
        sut.end(at: DicePosition(row: 3, col: 1))

        XCTAssertNil(board.swappedDirection)
    }

    func testSwapDexterForward() {
        sut.begin(at: DicePosition(row: 1, col: 1))
        sut.end(at: DicePosition(row: 3, col: 3))

        XCTAssertEqual(board.swappedDiagonal, .dexter)
        XCTAssertEqual(board.swappedDirection, .forward)
    }

    func testSwapDexterBackward() {
        sut.begin(at: DicePosition(row: 4, col: 4))
        sut.end(at: DicePosition(row: 3, col: 3))

        XCTAssertEqual(board.swappedDiagonal, .dexter)
        XCTAssertEqual(board.swappedDirection, .backward)
    }

    func testDontSwapDexterIfNotOnDiagonal() {
        sut.begin(at: DicePosition(row: 1, col: 2))
        sut.end(at: DicePosition(row: 4, col: 5))

        XCTAssertNil(board.swappedDirection)
    }

    func testSwapSinisterForward() {
        board.size = 5

        sut.begin(at: DicePosition(row: 0, col: 4))
        sut.end(at: DicePosition(row: 4, col: 0))

        XCTAssertEqual(board.swappedDiagonal, .sinister)
        XCTAssertEqual(board.swappedDirection, .forward)
    }

    func testSwapSinisterBackward() {
        board.size = 5

        sut.begin(at: DicePosition(row: 4, col: 0))
        sut.end(at: DicePosition(row: 0, col: 4))

        XCTAssertEqual(board.swappedDiagonal, .sinister)
        XCTAssertEqual(board.swappedDirection, .backward)
    }

    func testDontSwapIfRandomMoves() {
        sut.begin(at: DicePosition(row: 1, col: 2))
        sut.end(at: DicePosition(row: 2, col: 5))

        sut.begin(at: DicePosition(row: 1, col: 4))
        sut.end(at: DicePosition(row: 2, col: 1))

        XCTAssertNil(board.swappedDirection)
    }
}

class DiceBoardMock: SwappableBoard {
    var size: Int = .max
    var swappedRow: Int?
    var swappedCol: Int?
    var swappedDiagonal: Diagonal?
    var swappedDirection: DiceSwapDirection?

    func swap(rowAt row: Int, direction: DiceSwapDirection) {
        swappedRow = row
        swappedDirection = direction
    }

    func swap(colAt col: Int, direction: DiceSwapDirection) {
        swappedCol = col
        swappedDirection = direction
    }

    func swap(diagonal: Diagonal, direction: DiceSwapDirection) {
        swappedDiagonal = diagonal
        swappedDirection = direction
    }
}
