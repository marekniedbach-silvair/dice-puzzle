//
//  Created by Marek Niedbach on 02/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import Foundation

public enum Dice: Int {
    case one = 1
    case two
    case three
    case four
    case five
    case six

    public mutating func swap(_ direction: DiceSwapDirection) {
        switch direction {
        case .forward:
            self = Dice(rawValue: rawValue + 1) ?? .one
        case .backward:
            self = Dice(rawValue: rawValue - 1) ?? .six
        }
    }
}
