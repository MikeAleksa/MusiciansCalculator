//
//  SampleRate.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/15/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import Foundation

protocol SampleRate {
    
    static var sampleRate : Double { get set }
    
    static func set44100()
    static func set48000()
    static func set88200()
    static func set96000()
    static func getSR() -> Double
}

extension SampleRate {
    static func set44100() {
        sampleRate = 44100
    }
    
    static func set48000() {
        sampleRate = 48000
    }
    
    static func set88200() {
        sampleRate = 88200
    }
    
    static func set96000() {
        sampleRate = 96000
    }
    
    static func getSR() -> Double {
        return sampleRate
    }
}
