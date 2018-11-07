//
//  DiceBoardView.swift
//  DicePuzzle
//
//  Created by Marek Niedbach on 07/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import UIKit

@IBDesignable
class DiceBoardView: UIView {
    var dices = [DiceView]()
    let board = DiceBoard()
    var numberOfDices: Int { return board.size * board.size }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    func initialize() {
        for i in 0..<numberOfDices {
            let row = i / board.size
            let col = i % board.size
            let dice = makeDice(at: row, col: col)
            addSubview(dice)
            dices.append(dice)
        }

        dices[0].addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(diceDidSwipe)))
    }

    private func makeDice(at row: Int, col: Int) -> DiceView {
        let diceView = DiceView(frame: CGRect(x: col * 80, y: row * 80, width: 75, height: 75))
        diceView.accessibilityIdentifier = "dice_\(row)_\(col)"
        diceView.set(board.dice(atRow: row, col: col))
        return diceView
    }

    @objc private func diceDidSwipe(_ recognizer: UISwipeGestureRecognizer) {
        board.swap(rowAt: 0, direction: .forward)
        reloadRow(at: 0)
    }

    private func reloadRow(at row: Int) {
        for col in 0..<board.size {
            dices[col].set(board.dice(atRow: row, col: col))
        }
    }
}
