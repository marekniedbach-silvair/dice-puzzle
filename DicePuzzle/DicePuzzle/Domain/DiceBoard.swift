//
//  DiceBoard.swift
//  DicePuzzle
//
//  Created by Marek Niedbach on 02/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import Foundation

public class DiceBoard {
    public var size: Int { return dices.count }
    public var isResolved: Bool { return Set(dices.flatMap{$0}).count == 1 }
    private var dices: [[Dice]]

    public init(size: Int) {
        self.dices = Array(repeating: Array(repeating: Dice.one, count: size), count: size)
    }

    public func dice(atRow row: Int, col: Int) -> Dice? {
        guard isValidPosition(atRow: row, col: col) else { return nil }

        return dices[row][col]
    }

    public func swap(rowAt row: Int, direction: DiceSwapDirection) {
        for col in 0..<size {
            swapDice(atRow: row, col: col, direction: direction)
        }
    }

    public func swap(colAt col: Int, direction: DiceSwapDirection) {
        for row in 0..<size {
            swapDice(atRow: row, col: col, direction: direction)
        }
    }

    public func swap(diagonal: Diagonal, direction: DiceSwapDirection) {
        for i in 0..<size {
            switch diagonal {
            case .dexter:
                swapDice(atRow: i, col: i, direction: direction)
            case .sinister:
                swapDice(atRow: i, col: size - i - 1, direction: direction)
                break
            }
        }
    }

    private func isValidPosition(atRow row: Int, col: Int) -> Bool {
        return row < size && col < size
    }

    private func swapDice(atRow row: Int, col: Int, direction: DiceSwapDirection) {
        dices[row][col].swap(direction)
    }
}
