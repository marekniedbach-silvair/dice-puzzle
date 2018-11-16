//
//  Created by Marek Niedbach on 02/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import Foundation

public protocol DiceBoardDelegate: class {
    func diceBoard(_ diceBoard: DiceBoard, didUpdateDiceAt position: DicePosition)
}

public class DiceBoard {
    public static let defaultSize = 4
    
    public var size: Int { return dices.count }
    public var isResolved: Bool { return Set(dices.flatMap{$0}).count == 1 }
    public weak var delegate: DiceBoardDelegate?
    private var dices: [[Dice]]

    public init(size: Int = DiceBoard.defaultSize) {
        let row = Array(repeating: Dice.one, count: size)
        self.dices = Array(repeating: row, count: size)
    }

    public func dice(at position: DicePosition) -> Dice {
        return dices[position.row][position.col]
    }

    public func swap(rowAt row: Int, direction: DiceSwapDirection) {
        for col in 0..<size {
            let position = DicePosition(row: row, col: col)
            swapDice(at: position, direction: direction)
        }
    }

    public func swap(colAt col: Int, direction: DiceSwapDirection) {
        for row in 0..<size {
            let position = DicePosition(row: row, col: col)
            swapDice(at: position, direction: direction)
        }
    }

    public func swap(diagonal: Diagonal, direction: DiceSwapDirection) {
        for i in 0..<size {
            let position = dicePosition(on: diagonal, at: i)
            swapDice(at: position, direction: direction)
        }
    }

    private func swapDice(at position: DicePosition, direction: DiceSwapDirection) {
        dices[position.row][position.col].swap(direction)
        delegate?.diceBoard(self, didUpdateDiceAt: position)
    }

    private func dicePosition(on diagonal: Diagonal, at row: Int) -> DicePosition {
        switch diagonal {
        case .dexter:
            return DicePosition(row: row, col: row)
        case .sinister:
            return DicePosition(row: row, col: size - row - 1)
        }
    }
}
