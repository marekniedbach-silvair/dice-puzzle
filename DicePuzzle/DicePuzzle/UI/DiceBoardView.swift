//
//  Created by Marek Niedbach on 07/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import UIKit

@IBDesignable
class DiceBoardView: UIView {
    fileprivate let board = DiceBoard()
    fileprivate var dicesViews = [DicePosition: DiceView]()

    private var moveStartPosition = DicePosition(row: 0, col: 0)

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
        let position = dicePosition(at: location)

        switch recognizer.direction {
        case .left:
            board.swap(rowAt: position.row, direction: .backward)
        case .up:
            board.swap(colAt: position.col, direction: .backward)
        case .down:
            board.swap(colAt: position.col, direction: .forward)
        default:
            break
        }
    }

    private func dicePosition(at location: CGPoint) -> DicePosition {
        let row = Int(location.y) / diceSize
        let col = Int(location.x) / diceSize

        return DicePosition(row: row, col: col)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard let touch = touches.first else { return }

        moveStartPosition = dicePosition(at: touch.location(in: self))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        guard let touch = touches.first else { return }

        let moveEndPosition = dicePosition(at: touch.location(in: self))

        if moveStartPosition.row == moveEndPosition.row && moveStartPosition.col < moveEndPosition.col {
            board.swap(rowAt: moveEndPosition.row, direction: .forward)
        }
    }
}

extension DiceBoardView: DiceBoardDelegate {
    func diceBoard(_ diceBoard: DiceBoard, didUpdateDiceAt position: DicePosition) {
        let dice = board.dice(at: position)
        dicesViews[position]?.set(dice)
    }
}
