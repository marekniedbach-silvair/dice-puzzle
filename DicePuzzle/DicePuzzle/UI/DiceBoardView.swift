//
//  Created by Marek Niedbach on 07/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import UIKit

class DiceBoardView: UIView {
    private let board: DiceBoard
    private let boardSwapper: BoardSwapper
    private var dicesViews = [DicePosition: DiceView]()

    private var diceSize: CGFloat {
        return min(frame.width, frame.height) / CGFloat(board.size)
    }

    init(board: DiceBoard) {
        self.board = board
        self.boardSwapper = BoardSwapper(board: board)
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        for (position, view) in dicesViews {
            view.frame = diceFrame(at: position)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let position = self.dicePosition(from: touches) else { return }

        boardSwapper.begin(at: position)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let position = dicePosition(from: touches) else { return }

        boardSwapper.end(at: position)
    }

    private func initialize() {
        initBoard()
        initDicesViews(at: board.dicesPositions)
    }

    private func initDicesViews(at positions: [DicePosition]) {
        for position in positions {
            let dice = board.dice(at: position)
            dicesViews[position] = initDiceView(at: position, with: dice)
        }
    }

    private func initDiceView(at position: DicePosition, with dice: Dice) -> DiceView {
        let diceView = DiceView()
        diceView.accessibilityIdentifier = String(describing: position)
        diceView.set(dice)
        addSubview(diceView)
        return diceView
    }

    private func initBoard() {
        board.delegate = self
    }

    private func diceFrame(at position: DicePosition) -> CGRect {
        return CGRect(x: CGFloat(position.col) * diceSize,
                      y: CGFloat(position.row) * diceSize,
                      width: diceSize,
                      height: diceSize)
    }

    private func dicePosition(at location: CGPoint) -> DicePosition {
        let row = Int(location.y / diceSize)
        let col = Int(location.x / diceSize)

        return DicePosition(row: row, col: col)
    }

    private func dicePosition(from touches: Set<UITouch>) -> DicePosition? {
        guard let touch = touches.first else { return nil }

        return dicePosition(at: touch.location(in: self))
    }
}

extension DiceBoardView: DiceBoardDelegate {
    func diceBoard(_ diceBoard: DiceBoard, didUpdateDiceAt position: DicePosition) {
        let dice = board.dice(at: position)
        dicesViews[position]?.set(dice)
    }
}
