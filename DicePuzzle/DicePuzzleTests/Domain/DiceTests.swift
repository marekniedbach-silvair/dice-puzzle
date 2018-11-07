//
//  Created by Marek Niedbach on 02/11/2018.
//  Copyright © 2018 Marek Niedbach. All rights reserved.
//

import XCTest
import DicePuzzle

class DiceTests: XCTestCase {
    func testSwapDiceForward() {
        var dice: Dice = .one
        dice.swap(.forward)
        XCTAssertEqual(dice, .two)
        dice.swap(.forward)
        XCTAssertEqual(dice, .three)
        dice.swap(.forward)
        XCTAssertEqual(dice, .four)
        dice.swap(.forward)
        XCTAssertEqual(dice, .five)
        dice.swap(.forward)
        XCTAssertEqual(dice, .six)
        dice.swap(.forward)
        XCTAssertEqual(dice, .one)
    }

    func testSwapDiceBackward() {
        var dice: Dice = .one
        dice.swap(.backward)
        XCTAssertEqual(dice, .six)
        dice.swap(.backward)
        XCTAssertEqual(dice, .five)
        dice.swap(.backward)
        XCTAssertEqual(dice, .four)
        dice.swap(.backward)
        XCTAssertEqual(dice, .three)
        dice.swap(.backward)
        XCTAssertEqual(dice, .two)
        dice.swap(.backward)
        XCTAssertEqual(dice, .one)
    }
}
