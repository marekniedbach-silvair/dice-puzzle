//
//  Created by Marek Niedbach on 07/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import UIKit

@IBDesignable
class DiceBoardView: UIView {
    fileprivate let board = DiceBoard()
    fileprivate var dicesViews = [DicePosition: DiceView]()
    private var diceSize: Int {
        return Int(min(frame.width, frame.height)) / board.size
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        for position in board.dicesPositions {
            dicesViews[position]?.frame = diceFrame(at: position)
        }
    }

    private func initialize() {
        initDicesViews()
        initGestures()
        initBoard()
    }

    private func initDicesViews() {
        for position in board.dicesPositions {
            dicesViews[position] = initDiceView(at: position)
        }
    }

    private func initDiceView(at position: DicePosition) -> DiceView {
        let diceView = DiceView()
        diceView.accessibilityIdentifier = String(describing: position)
        addSubview(diceView)
        return diceView
    }

    private func initGestures() {
        initGestureRecognizer(direction: .left)
        initGestureRecognizer(direction: .right)
        initGestureRecognizer(direction: .down)
        initGestureRecognizer(direction: .up)
    }

    private func initGestureRecognizer(direction: UISwipeGestureRecognizer.Direction) {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(boardDidSwipe))
        recognizer.direction = direction
        addGestureRecognizer(recognizer)
    }

    private func initBoard() {
        board.delegate = self
    }

    private func diceFrame(at position: DicePosition) -> CGRect {
        return CGRect(x: position.col * diceSize,
                      y: position.row * diceSize,
                      width: diceSize,
                      height: diceSize)
    }

    @objc private func boardDidSwipe(_ recognizer: UISwipeGestureRecognizer) {
        let location = recognizer.location(in: self)
        let row = Int(location.y) / diceSize
        let col = Int(location.x) / diceSize

        switch recognizer.direction {
        case .left:
            board.swap(rowAt: row, direction: .backward)
        case .right:
            board.swap(rowAt: row, direction: .forward)
        case .up:
            board.swap(colAt: col, direction: .backward)
        case .down:
            board.swap(colAt: col, direction: .forward)
        default:
            break
        }
    }
}

extension DiceBoardView: DiceBoardDelegate {
    func diceBoard(_ diceBoard: DiceBoard, didUpdateDiceAt position: DicePosition) {
        let dice = board.dice(at: position)
        dicesViews[position]?.set(dice)
    }
}
