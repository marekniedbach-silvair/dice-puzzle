//
//  Created by Marek Niedbach on 06/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import UIKit

@IBDesignable
class DiceView: UIView {
    private let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    func set(_ dice: Dice) {
        label.text = "\(dice.rawValue)"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        backgroundColor = .lightGray
        initializeLabel()
    }

    private func initializeLabel() {
        label.text = "1"
        addSubview(label)
    }
}
