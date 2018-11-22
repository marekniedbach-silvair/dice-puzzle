//
//  Created by Marek Niedbach on 16/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import Foundation

public struct DicePosition: Equatable {
    public let row: Int
    public let col: Int

    public init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
}

extension DicePosition: CustomStringConvertible {
    public var description: String { return "dice_\(row)_\(col)" }
}
