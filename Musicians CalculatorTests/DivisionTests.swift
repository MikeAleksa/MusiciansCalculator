//
//  DivisionTests.swift
//  Musicians CalculatorTests
//
//  Created by Michael Aleksa on 12/17/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import XCTest

class DivisionTests: XCTestCase {

    var dvQuarter : Division!
    var dvEighth : Division!

    override func setUp() {
        dvQuarter = Division(withName: "1/4")
        dvEighth = Division(withName: "1/8")
    }

    func testInitQuarter120bpm44100() {
        Division.setUnmodified()
        Division.setBPM(withbpm: 120)
        SampleRate.set44100()
        XCTAssertEqual(dvQuarter.getName(), String("1/4"))
        XCTAssertEqual(dvQuarter.getMilliseconds(), 500.0)
        XCTAssertEqual(dvQuarter.getSamples(), 22050.0)
    }
    
    func testQuarterGetMilliseconds130bpm44100() {
        Division.setUnmodified()
        Division.setBPM(withbpm: 130)
        SampleRate.set44100()
        XCTAssertEqual(dvQuarter.getMilliseconds(), (60000.0/130.0))
    }
    
    func testQuarterGetSamples140bpm88200() {
        Division.setUnmodified()
        Division.setBPM(withbpm: 140)
        SampleRate.set88200()
        XCTAssertEqual(dvQuarter.getSamples(), (60.0*88200.0/140.0))
    }
    
    func testInitEighth155bpm96000() {
        Division.setUnmodified()
        Division.setBPM(withbpm: 155)
        SampleRate.set96000()
        XCTAssertEqual(dvEighth.getName(), String("1/8"))
        XCTAssertEqual(dvEighth.getMilliseconds(), (60000.0/155.0/2.0))
        XCTAssertEqual(dvEighth.getSamples(), (60.0*96000.0/155.0/2.0))
    }
    
    func testEighthGetMilliseconds120bpm44100() {
        Division.setUnmodified()
        Division.setBPM(withbpm: 120)
        SampleRate.set44100()
        XCTAssertEqual(dvEighth.getMilliseconds(), (60.0/120.0/2.0))
    }
    
    func testEighthGetSamples130bpm48000() {
        Division.setUnmodified()
        Division.setBPM(withbpm: 130)
        SampleRate.set48000()
        XCTAssertEqual(dvEighth.getSamples(), (60.0*48000.0/130.0/2.0))
    }
    
    func testDottedQuarterGetMilliseconds120bpm44100() {
        Division.setDotted()
        Division.setBPM(withbpm: 120)
        XCTAssertEqual(dvQuarter.getMilliseconds(), 750.0)
    }
    
    func testTripletQuarterGetMilliseconds120bpm44100() {
        Division.setTriplet()
        Division.setBPM(withbpm: 120)
        XCTAssertEqual(dvQuarter.getMilliseconds(), 500.0*(2.0/3.0))
    }
    
    func testUnmodifiedQuarterGetMilliseconds120bpm44100() {
        Division.setUnmodified()
        Division.setBPM(withbpm: 120)
        XCTAssertEqual(dvQuarter.getMilliseconds(), 500.0)
    }
    
}

