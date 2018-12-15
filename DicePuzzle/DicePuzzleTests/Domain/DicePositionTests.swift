//
//  Created by Marek Niedbach on 19/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import XCTest
import DicePuzzle

class DicePositionTests: XCTestCase {

    func testStringConversion() {
        let sut = DicePosition(row: 1, col: 2)
        XCTAssertEqual(String(describing: sut), "dice_1_2")
    }
}
