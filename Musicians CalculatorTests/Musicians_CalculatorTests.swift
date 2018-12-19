//
//  Musicians_CalculatorTests.swift
//  Musicians CalculatorTests
//
//  Created by Michael Aleksa on 12/17/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import XCTest

class Musicians_CalculatorTests: XCTestCase {
    
    var mc = MusiciansCalculator()
    
    override func setUp() {
        mc.setBPM(withbpm: 120)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetDotted() {
        mc.setDotted()
        XCTAssertEqual(mc.divisions[4].getMilliseconds(), 750.0)
    }
    
    func testSetTriplet() {
        mc.setTriplet()
        XCTAssertEqual(mc.divisions[4].getMilliseconds(), 500.0*(2.0/3.0))
    }
    
    func testNoModifier() {
        XCTAssertEqual(mc.divisions[4].getMilliseconds(), 500.0)
    }
}

