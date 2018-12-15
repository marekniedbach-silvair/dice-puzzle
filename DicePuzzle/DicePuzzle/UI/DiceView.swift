//
//  Created by Marek Niedbach on 06/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import UIKit

class DiceView: UIView {
    private let label = UILabel()

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
        initializeLabel()
    }

    private func initializeLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
        label.backgroundColor = .lightGray
    }
}
