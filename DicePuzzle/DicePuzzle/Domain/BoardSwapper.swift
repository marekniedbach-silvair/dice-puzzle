//
//  Created by Marek Niedbach on 06/12/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import Foundation

public protocol SwappableBoard {
    var size: Int { get }
    func swap(rowAt row: Int, direction: DiceSwapDirection)
    func swap(colAt col: Int, direction: DiceSwapDirection)
    func swap(diagonal: Diagonal, direction: DiceSwapDirection)
}

public class BoardSwapper {
    private let board: SwappableBoard
    private var beginPosition = DicePosition(row: 0, col: 0)
    private var endPosition = DicePosition(row: 0, col: 0)
    private var swappedOnDexter: Bool {
        return isOnDexter(beginPosition) && isOnDexter(endPosition)
    }
    private var swappedOnSinister: Bool {
        return isOnSinister(beginPosition) && isOnSinister(endPosition)
    }

    public init(board: SwappableBoard) {
        self.board = board
    }

    public func begin(at position: DicePosition) {
        beginPosition = position
    }

    public func end(at position: DicePosition) {
        endPosition = position
        detectSwap()
    }

    private func detectSwap() {
        let rowIndex = beginPosition.row
        let colIndex = beginPosition.col

        switch positionChange() {
        case (rowChange: .unchanged, colChange: .incremented):
            board.swap(rowAt: rowIndex, direction: .forward)
        case (rowChange: .unchanged, colChange: .decremented):
            board.swap(rowAt: rowIndex, direction: .backward)
        case (rowChange: .incremented, colChange: .unchanged):
            board.swap(colAt: colIndex, direction: .forward)
        case (rowChange: .decremented, colChange: .unchanged):
            board.swap(colAt: colIndex, direction: .backward)
        case (rowChange: .incremented, colChange: .incremented) where swappedOnDexter:
            board.swap(diagonal: .dexter, direction: .forward)
        case (rowChange: .decremented, colChange: .decremented) where swappedOnDexter:
            board.swap(diagonal: .dexter, direction: .backward)
        case (rowChange: .incremented, colChange: .decremented) where swappedOnSinister:
            board.swap(diagonal: .sinister, direction: .forward)
        case (rowChange: .decremented, colChange: .incremented) where swappedOnSinister:
            board.swap(diagonal: .sinister, direction: .backward)
        default:
            break
        }
    }

    private func isOnDexter(_ position: DicePosition) -> Bool {
        return position.row == position.col
    }

    private func isOnSinister(_ position: DicePosition) -> Bool {
        return position.row == board.size - position.col - 1
    }

    private func positionChange() -> (rowChange: Change, colChange: Change) {
        let rowChange = Change.detected(from: beginPosition.row, to: endPosition.row)
        let colChange = Change.detected(from: beginPosition.col, to: endPosition.col)
        return (rowChange: rowChange, colChange: colChange)
    }

    private enum Change {
        case incremented
        case decremented
        case unchanged

        static func detected(from begin: Int, to end: Int) -> Change {
            if begin < end {
                return .incremented
            } else if begin > end {
                return .decremented
            } else {
                return .unchanged
            }
        }
    }
}
