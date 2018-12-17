//
//  SampleRateTests.swift
//  Musicians CalculatorTests
//
//  Created by Michael Aleksa on 12/17/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import XCTest

class SampleRateTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSet44100() {
        SampleRate.set44100()
        let samplerate = SampleRate.getSR()
        XCTAssertTrue(samplerate == 44100)
    }
    
    func testSet48000() {
        SampleRate.set48000()
        let samplerate = SampleRate.getSR()
        XCTAssertTrue(samplerate == 48000)
    }
    
    func testSet88200() {
        SampleRate.set88200()
        let samplerate = SampleRate.getSR()
        XCTAssertTrue(samplerate == 88200)
    }
    
    func testSet96000() {
        SampleRate.set96000()
        let samplerate = SampleRate.getSR()
        XCTAssertTrue(samplerate == 96000)
    }
}



