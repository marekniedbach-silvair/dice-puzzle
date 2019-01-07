//
//  Created by Marek Niedbach on 07/01/2019.
//  Copyright © 2019 Marek Niedbach. All rights reserved.
//

import XCTest
@testable import DicePuzzle

class BoardRandomizer {
    private let board: SwappableBoard
    var nextRandom: (() -> Int) = { return 0 }

    init(board: SwappableBoard) {
        self.board = board
    }

    func randomize(steps: Int) {
        let random = nextRandom()

        let size = board.size
        let index = random % size
        let isRow = random / size == 0
        let isColumn = random / size == 1
        let isDexter = random / size == 2 && index == 0
        let isSinister = random / size == 2 && index == 1

        if isRow {
            board.swap(rowAt: index, direction: .forward)
        } else if isColumn {
            board.swap(colAt: index, direction: .forward)
        } else if isDexter {
            board.swap(diagonal: .dexter, direction: .forward)
        } else if isSinister {
            board.swap(diagonal: .sinister, direction: .forward)
        }
    }
}

class BoardRandomizerTests: XCTestCase {
    private let board = DiceBoardMock()
    private lazy var sut = BoardRandomizer(board: board)

    func testSwapFirstRowForward() {
        sut.nextRandom = { return 0 }

        sut.randomize(steps: 1)

        XCTAssertEqual(board.swappedRow, 0)
        XCTAssertEqual(board.swappedDirection, .forward)
    }

    func testSwapLastRowForward() {
        board.size = 7
        sut.nextRandom = { return 6 }

        sut.randomize(steps: 1)

        XCTAssertEqual(board.swappedRow, 6)
        XCTAssertEqual(board.swappedDirection, .forward)
    }

    func testSwapFirstColumnForward() {
        board.size = 3
        sut.nextRandom = { return 3 }

        sut.randomize(steps: 1)

        XCTAssertEqual(board.swappedCol, 0)
        XCTAssertEqual(board.swappedDirection, .forward)
    }

    func testSwapLastColumnForward() {
        board.size = 2
        sut.nextRandom = { return 3 }

        sut.randomize(steps: 1)

        XCTAssertEqual(board.swappedCol, 1)
        XCTAssertEqual(board.swappedDirection, .forward)
    }

    func testSwapDexterForward() {
        board.size = 2
        sut.nextRandom = { return 4 }

        sut.randomize(steps: 1)

        XCTAssertEqual(board.swappedDiagonal, .dexter)
        XCTAssertEqual(board.swappedDirection, .forward)
    }

    func testSwapSinisterForward() {
        board.size = 2
        sut.nextRandom = { return 5 }

        sut.randomize(steps: 1)

        XCTAssertEqual(board.swappedDiagonal, .sinister)
        XCTAssertEqual(board.swappedDirection, .forward)
    }
}
