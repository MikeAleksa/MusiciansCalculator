//
//  DivisionTests.swift
//  Musicians CalculatorTests
//
//  Created by Michael Aleksa on 12/17/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import XCTest

class DivisionTests: XCTestCase {

    let mod: Double = 1.0
    var bpm : Double = 0.0
    var sr : Double = 0.0
    var dvQuarter : Division!
    var dvEighth : Division!

    override func setUp() {
        bpm = 120
        sr = 44100
        dvQuarter = Division(withName: "1/4", withbpm: bpm, withsr: sr, withMod: mod)
        dvEighth = Division(withName: "1/8", withbpm: bpm, withsr: sr, withMod: mod)

    }

    func testInitQuarter() {
        XCTAssertEqual(dvQuarter.getName(), String("1/4"))
        XCTAssertEqual(dvQuarter.getMilliseconds(), Double(500))
        XCTAssertEqual(dvQuarter.getSamples(), Double(22050))
    }
    
    func testQuarterGetMilliseconds() {
        bpm = 130
        sr = 44100
        dvQuarter.updateTimes(withbpm: bpm, withsr: sr, withMod: mod)
        XCTAssertEqual(dvQuarter.getMilliseconds(), (60000.0/130.0))
    }
    
    func testQuarterGetSamples() {
        bpm = 130
        sr = 88200
        dvQuarter.updateTimes(withbpm: bpm, withsr: sr, withMod: mod)
        XCTAssertEqual(dvQuarter.getSamples(), (60.0*88200.0/130.0))
    }
    
    func testInitEighth() {
        XCTAssertEqual(dvEighth.getName(), String("1/8"))
        XCTAssertEqual(dvEighth.getMilliseconds(), Double(250))
        XCTAssertEqual(dvEighth.getSamples(), Double(11025))
    }
    
    func testEighthGetMilliseconds() {
        bpm = 130
        sr = 44100
        dvEighth.updateTimes(withbpm: bpm, withsr: sr, withMod: mod)
        XCTAssertEqual(dvEighth.getMilliseconds(), (60000.0/130.0/2.0))
    }
    
    func testEighthGetSamples() {
        bpm = 130
        sr = 88200
        dvEighth.updateTimes(withbpm: bpm, withsr: sr, withMod: mod)
        XCTAssertEqual(dvEighth.getSamples(), (60.0*88200.0/130.0/2.0))
    }
    
}
