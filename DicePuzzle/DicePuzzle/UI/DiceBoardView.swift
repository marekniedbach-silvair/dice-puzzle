//
//  Created by Marek Niedbach on 07/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import UIKit

@IBDesignable
class DiceBoardView: UIView {
    fileprivate var dices = [[DiceView]]()
    fileprivate let board = DiceBoard()
    fileprivate let diceSize = 80

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
        initBoard()
    }

    private func initDices() {
        for row in 0..<board.size {
            var rowDices = [DiceView]()
            for col in 0..<board.size {
                let dice = makeDice(at: DicePosition(row: row, col: col))
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

    private func initBoard() {
        board.delegate = self
    }

    private func initGestureRecognizer(direction: UISwipeGestureRecognizerDirection) {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(boardDidSwipe))
        recognizer.direction = direction
        addGestureRecognizer(recognizer)
    }

    private func makeDice(at position: DicePosition) -> DiceView {
        let diceView = DiceView(frame: diceFrame(at: position))
        diceView.accessibilityIdentifier = diceAccessibilityId(at: position)
        diceView.set(dice(at: position))
        return diceView
    }

    private func diceFrame(at position: DicePosition) -> CGRect {
        return CGRect(x: position.col * diceSize,
                      y: position.row * diceSize,
                      width: diceSize,
                      height: diceSize)
    }

    private func diceAccessibilityId(at position: DicePosition) -> String {
        return "dice_\(position.row)_\(position.col)"
    }

    private func dice(at position: DicePosition) -> Dice {
        return board.dice(at: position)
    }

    @objc private func boardDidSwipe(_ recognizer: UISwipeGestureRecognizer) {
        let location = recognizer.location(in: self)
        let row = Int(location.y) / diceSize
        let col = Int(location.x) / diceSize

        switch recognizer.direction {
        case .right:
            swipe(row: row, direction: .forward)
        case .left:
            swipe(row: row, direction: .backward)
        case .up:
            swipe(col: col, direction: .backward)
        case .down:
            swipe(col: col, direction: .forward)
        default:
            break
        }
    }

    private func swipe(row: Int, direction: DiceSwapDirection) {
        board.swap(rowAt: row, direction: direction)
    }

    private func swipe(col: Int, direction: DiceSwapDirection) {
        board.swap(colAt: col, direction: direction)
    }
}

extension DiceBoardView: DiceBoardDelegate {
    func diceBoard(_ diceBoard: DiceBoard, didUpdateDiceAt position: DicePosition) {
        let dice = board.dice(at: position)
        diceView(at: position).set(dice)
    }

    private func diceView(at position: DicePosition) -> DiceView {
        return dices[position.row][position.col]
    }
}
