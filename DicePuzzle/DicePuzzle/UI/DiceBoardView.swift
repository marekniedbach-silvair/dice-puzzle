//
//  Created by Marek Niedbach on 07/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import UIKit

@IBDesignable
class DiceBoardView: UIView {
    private var dices = [[DiceView]]()
    private let board = DiceBoard()
    private let diceSize = 80

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    func initialize() {
        initDices()
        initGestures()
    }

    private func initDices() {
        for row in 0..<board.size {
            var rowDices = [DiceView]()
            for col in 0..<board.size {
                let dice = makeDice(at: row, col: col)
                addSubview(dice)
                rowDices.append(dice)
            }
            dices.append(rowDices)
        }
    }

    private func initGestures() {
        initGestureRecognizer(direction: .left)
        initGestureRecognizer(direction: .right)
        initGestureRecognizer(direction: .down)
        initGestureRecognizer(direction: .up)
    }

    private func initGestureRecognizer(direction: UISwipeGestureRecognizerDirection) {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(boardDidSwipe))
        recognizer.direction = direction
        addGestureRecognizer(recognizer)
    }

    private func makeDice(at row: Int, col: Int) -> DiceView {
        let diceView = DiceView(frame: CGRect(x: col * diceSize, y: row * diceSize, width: diceSize, height: diceSize))
        diceView.accessibilityIdentifier = "dice_\(row)_\(col)"
        diceView.set(board.dice(atRow: row, col: col))
        return diceView
    }

    @objc private func boardDidSwipe(_ recognizer: UISwipeGestureRecognizer) {
        let location = recognizer.location(in: self)
        let row = Int(location.y) / diceSize
        let col = Int(location.x) / diceSize

        switch recognizer.direction {
        case .left:
            swipe(row: row, direction: .forward)
        case .right:
            swipe(row: row, direction: .backward)
        case .up:
            swipe(col: col, direction: .backward)
        case .down:
            swipe(col: col, direction: .backward)
        default:
            break
        }
    }

    private func swipe(row: Int, direction: DiceSwapDirection) {
        board.swap(rowAt: row, direction: direction)
        reloadRow(at: row)
    }

    private func swipe(col: Int, direction: DiceSwapDirection) {
        board.swap(colAt: col, direction: direction)
        reloadRow(at: col)
    }

    private func reloadRow(at row: Int) {
        for col in 0..<board.size {
            let dice = board.dice(atRow: row, col: col)
            diceView(atRow: row, col: col).set(dice)
        }
    }

    private func reloadColumn(at col: Int) {
        for row in 0..<board.size {
            let dice = board.dice(atRow: row, col: col)
            diceView(atRow: row, col: col).set(dice)
        }
    }

    private func diceView(atRow row: Int, col: Int) -> DiceView {
        return dices[row][col]
    }
}
