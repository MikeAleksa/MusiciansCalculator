//
//  SampleRateTests.swift
//  Musicians CalculatorTests
//
//  Created by Michael Aleksa on 12/17/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import XCTest

class SampleRateTests: XCTestCase {
    
    func testSet44100() {
        Division.set44100()
        let samplerate = Division.getSR()
        XCTAssertTrue(samplerate == 44100)
    }
    
    func testSet48000() {
        Division.set48000()
        let samplerate = Division.getSR()
        XCTAssertTrue(samplerate == 48000)
    }
    
    func testSet88200() {
        Division.set88200()
        let samplerate = Division.getSR()
        XCTAssertTrue(samplerate == 88200)
    }
    
    func testSet96000() {
        Division.set96000()
        let samplerate = Division.getSR()
        XCTAssertTrue(samplerate == 96000)
    }
}



